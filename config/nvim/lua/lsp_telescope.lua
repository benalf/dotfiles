local M = {}

local function normalize(path)
	if not path or path == "" then
		return ""
	end

	if vim.fs and vim.fs.normalize then
		return vim.fs.normalize(path)
	end

	return vim.fn.fnamemodify(path, ":p")
end

local function starts_with(value, prefix)
	return value:sub(1, #prefix) == prefix
end

local function escape_pattern(value)
	return value:gsub("([^%w])", "%%%1")
end

local function workspace_root(bufnr)
	local filename = vim.api.nvim_buf_get_name(bufnr)
	if filename == "" then
		return normalize(vim.uv.cwd())
	end

	if vim.fs and vim.fs.root then
		local root = vim.fs.root(filename, { "Cargo.toml", ".git" })
		if root then
			return normalize(root)
		end
	end

	return normalize(vim.uv.cwd())
end

local function definition_score(item, root, word)
	local filename = normalize(item.filename)
	local text = item.text or ""
	local score = 0

	if root ~= "" and starts_with(filename, root .. "/") then
		score = score - 1000
	else
		score = score + 1000
	end

	if filename:match("/src/") then
		score = score - 200
	end

	if filename:match("%.cargo/registry") or filename:match("%.cargo/git/checkouts") then
		score = score + 800
	end

	if filename:match("%.rustup/toolchains") or filename:match("/rustc/") then
		score = score + 800
	end

	if filename:match("/target/") then
		score = score + 600
	end

	if text:match("^%s*#%[") then
		score = score + 400
	end

	if word ~= "" then
		local escaped_word = escape_pattern(word)
		local basename = vim.fn.fnamemodify(filename, ":t:r"):lower()
		local lower_word = word:lower()

		if text:match("fn%s+" .. escaped_word .. "%f[%W]") then
			score = score - 600
		elseif text:match(escaped_word) then
			score = score - 100
		end

		if basename == lower_word then
			score = score - 250
		end
	end

	return score
end

local function sorted_definitions(items, root, word)
	for index, item in ipairs(items) do
		item._definition_score = definition_score(item, root, word)
		item._definition_index = index
	end

	table.sort(items, function(left, right)
		if left._definition_score ~= right._definition_score then
			return left._definition_score < right._definition_score
		end

		if left.filename ~= right.filename then
			return left.filename < right.filename
		end

		if left.lnum ~= right.lnum then
			return left.lnum < right.lnum
		end

		if left.col ~= right.col then
			return left.col < right.col
		end

		return left._definition_index < right._definition_index
	end)

	return items
end

function M.definitions()
	local bufnr = vim.api.nvim_get_current_buf()
	local winnr = vim.api.nvim_get_current_win()
	local root = workspace_root(bufnr)
	local word = vim.fn.expand("<cword>")
	local params = function(client)
		return vim.lsp.util.make_position_params(winnr, client.offset_encoding)
	end

	vim.lsp.buf_request_all(bufnr, "textDocument/definition", params, function(results_per_client)
		local items = {}
		local first_encoding

		for client_id, result_or_error in pairs(results_per_client) do
			if result_or_error.err then
				vim.notify("LSP definition: " .. result_or_error.err.message, vim.log.levels.ERROR)
			elseif result_or_error.result then
				local locations = result_or_error.result
				if not vim.islist(locations) then
					locations = { locations }
				end

				local client = vim.lsp.get_client_by_id(client_id)
				local offset_encoding = client and client.offset_encoding or "utf-16"
				if not vim.tbl_isempty(locations) and not first_encoding then
					first_encoding = offset_encoding
				end

				vim.list_extend(items, vim.lsp.util.locations_to_items(locations, offset_encoding))
			end
		end

		if vim.tbl_isempty(items) then
			vim.notify("No LSP definitions found", vim.log.levels.INFO)
			return
		end

		items = sorted_definitions(items, root, word)

		if #items == 1 then
			vim.lsp.util.show_document(items[1].user_data, first_encoding or "utf-16", { reuse_win = false })
			return
		end

		local pickers = require("telescope.pickers")
		local finders = require("telescope.finders")
		local make_entry = require("telescope.make_entry")
		local conf = require("telescope.config").values
		local opts = {
			bufnr = bufnr,
			winnr = winnr,
			trim_text = true,
		}
		local make_quickfix_entry = make_entry.gen_from_quickfix(opts)

		pickers
			.new(opts, {
				prompt_title = "LSP Definitions",
				finder = finders.new_table({
					results = items,
					entry_maker = function(item)
						local entry = make_quickfix_entry(item)
						if entry then
							entry.ordinal = string.format("%04d %s", item._definition_score + 5000, entry.ordinal)
						end
						return entry
					end,
				}),
				previewer = conf.qflist_previewer(opts),
				sorter = conf.generic_sorter(opts),
				push_cursor_on_edit = true,
				push_tagstack_on_edit = true,
			})
			:find()
	end)
end

return M
