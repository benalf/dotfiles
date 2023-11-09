def main [container] {
  docker logs -f $container
  | lines
  | split column "\t"
  | default "" column3
  | default "" column4
  | default "" column5
  | each {|row|
    let type = ($row.column3 | ansi strip | str trim)

    {
      type: $type
      message: (match $type {
        "http" => (try_from_json $row.column5)
        "service" => (try_from_json $row.column4)
        "server" => (try_from_json $row.column5)
      })
      meta: $row.column4
    }
  }
}

def try_from_json [json] {
  try {
    $json | from json
  } catch {
    $json
  }
}
