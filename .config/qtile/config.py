import os
import subprocess
from libqtile import bar, layout, widget, hook, extension
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy


home = os.path.expanduser('~')
@hook.subscribe.startup_once
def start_once():
    subprocess.call([home + '/.config/qtile/scripts/autostart.sh'])

terminal = "tilix"

bar_color = "#00000070"
border_color = "#1D2330"
focus_color = "#3041b5"
colors = [["#00000080", "#00000080"],
          ["#050b40", "#050b40"],
          ["#dfdfdf", "#dfdfdf"],
          ["#ff6c6b", "#ff6c6b"],
          ["#050b40", "#050b40"],
          ["#da8548", "#da8548"],
          ["#2a0540", "#2a0540"],
          ["#c678dd", "#c678dd"],
          ["#46d9ff", "#46d9ff"],
          ["#a9a1e1", "#a9a1e1"]]


widget_defaults = dict(
    font="VictorMono Nerd Font Mono Bold",
    fontsize = 12,
    padding = 2,
    background = bar_color,
)
extension_defaults = widget_defaults.copy()


def init_widgets_list():
    widgets_list = [
        widget.Sep(
            linewidth = 0,
            padding = 6,
        ),
        widget.Sep(
            linewidth = 0,
            padding = 6,
        ),
        widget.GroupBox(
            fontsize = 9,
            margin_y = 3,
            margin_x = 0,
            padding_y = 5,
            padding_x = 3,
            borderwidth = 3,
            active = colors[2],
            inactive = colors[7],
            rounded = False,
            highlight_color = colors[1],
            highlight_method = "line",
            this_current_screen_border = colors[6],
            this_screen_border = colors [4],
            other_current_screen_border = colors[6],
            other_screen_border = colors[4],
        ),
        widget.TextBox(
            text = ' ',
        ),
        widget.CurrentLayout(
            foreground = colors[3],
        ),
        widget.TextBox(
            text = ' ',
        ),
        widget.WindowName(
            foreground = colors[7],
            padding = 0
        ),
        widget.StatusNotifier(
            padding = 5
        ),
        widget.TextBox(
            text = ' ',
            foreground = colors[6],
            padding = 0,
            fontsize = 37
        ),
        widget.Memory(
            foreground = colors[7],
            background = colors[6],
            mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(terminal + ' -e htop')},
            fmt = 'Mem: {} ',
            padding = 5
        ),
        widget.TextBox(
            text = '',
            background = colors[6],
            foreground = colors[4],
            padding = 0,
            fontsize = 37
        ),
        widget.Clock(
            foreground = colors[3],
            background = colors[4],
            format = "%A, %B %d - %H:%M "
        ),
    ]
    return widgets_list


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    del widgets_screen1[7:9]

    return widgets_screen1


def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()

    return widgets_screen2 


def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=24, background="#00000000")),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=1.0, size=24, background="#00000000"))]

if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()


mod = "mod4"

keys = [
    Key([mod], "m", lazy.next_screen()),

    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    Key([mod], "Escape", lazy.spawn("dm-tool lock"), desc="Lock"),

    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),

    Key(["control", "mod1"], "l", lazy.spawn("lxdm -c USER_SWITCH")),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([], "Print",
        lazy.spawn("scrot -s --line mode=edge '/tmp/%F_%T_$wx$h.png' -e 'xclip -selection clipboard -target image/png -i $f'"),
    ),

    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "t", lazy.spawn("tilix"), desc="Launch terminal"),
    Key([mod], "y", lazy.spawn("nvim"), desc="Launch nvim"),
    Key([mod], "f", lazy.spawn("nemo"), desc="Launch nautilus"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key(["shift", "mod1"], "f",  lazy.window.toggle_floating()),
    Key([mod], "r", lazy.spawn("rofi -show drun")),
    Key([mod, "shift"], "r", lazy.spawn("rofi -show combi")),
]


layout_theme = {
    "border_width": 1,
    "margin": 4,
    "border_focus": colors[7],
    "border_normal": "1D2330",
    "border_on_single": True,
}

layouts = [
    layout.Columns(**layout_theme),
    layout.Max(**layout_theme),
]

groups = [
    Group("1", layout='columns'),
    Group(
        "2",
        layouts=[
            layout.Columns(**{**layout_theme,** {
                "num_columns": 3,
            }}),
            layout.Max(**layout_theme)
        ],
    ),
    Group("3", layout='columns'),
    Group("4", layout='columns'),
    Group("5", layout='columns'),
    Group("6", layout='columns'),
    Group("7", layout='columns'),
]
from libqtile.dgroups import simple_key_binder
dgroups_key_binder = simple_key_binder("mod4")



mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

groups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
follow_mouse_focus = False
auto_minimize = True

wl_input_rules = None
wmname = "LG3D"

