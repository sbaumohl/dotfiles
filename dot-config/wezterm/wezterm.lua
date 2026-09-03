local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux
local config = wezterm.config_builder()

-- Directory scanned for one-keystroke project workspaces.
local PROJECT_ROOT = wezterm.home_dir .. '/Files'

-- Retro = terminal-grid tab bar, fully styled below. Flip to true for
-- wezterm's native rounded GUI tab bar (separators are dropped automatically).
local USE_FANCY_TAB_BAR = false

-- tokyonight (storm) palette, for the tab bar and status line.
local P = {
    bg = '#24283b',
    bg_dark = '#1f2335',
    bg_highlight = '#292e42',
    fg = '#c0caf5',
    comment = '#565f89',
    blue = '#7aa2f7',
    cyan = '#7dcfff',
    green = '#9ece6a',
    magenta = '#bb9af7',
    red = '#f7768e',
    orange = '#ff9e64',
}

-- Nerd Font glyphs, by codepoint so this file stays plain ASCII.
local I = {
    folder   = utf8.char(0xf07b),
    home     = utf8.char(0xf015),
    terminal = utf8.char(0xf120),
    tag      = utf8.char(0xf02b),
    grid     = utf8.char(0xf00a),
    circle   = utf8.char(0xf111),
    vim      = utf8.char(0xe62b),
    git      = utf8.char(0xe702),
    rust     = utf8.char(0xe7a8),
    python   = utf8.char(0xe73c),
    node     = utf8.char(0xe718),
    docker   = utf8.char(0xf308),
    globe    = utf8.char(0xf0ac),
    cogs     = utf8.char(0xf085),
    lua      = utf8.char(0xe620),
    chart    = utf8.char(0xf080),
    book     = utf8.char(0xf02d),
    bolt     = utf8.char(0xf0e7),
}

-- Font ----------------------------------------------------------------------

-- Lilex exposes: calt case cv01-cv15 frac onum ordn ss01-ss04 subs sups zero
--   calt = contextual alternates, i.e. the coding ligatures (-> != >=)
--   zero = slashed zero
-- The cv*/ss* sets are font-specific glyph variants; the fastest way to see
-- what each does is to add it here and save -- the config reloads instantly.
-- To kill ligatures entirely, swap calt for: 'calt=0', 'clig=0', 'liga=0'
local FONT_FEATURES = { 'calt', 'zero' }

config.font = wezterm.font_with_fallback({
    'lilex', 'JetBrains Mono', 'Symbols Nerd Font'
}, { harfbuzz_features = FONT_FEATURES })
-- config.enable_wayland = false;

-- Appearance ----------------------------------------------------------------

-- Matches the tokyonight (storm) colorscheme in nvim.
config.color_scheme = 'tokyonight_storm'

-- Window frame: no titlebar, still draggable/resizable from the edges.
config.window_decorations = 'RESIZE'
config.window_padding = {
    left = 12,
    right = 12,
    top = 10,
    bottom = 6,
}
config.adjust_window_size_when_changing_font_size = false

-- Fade panes that don't have focus.
config.inactive_pane_hsb = {
    saturation = 0.8,
    brightness = 0.65,
}

-- Tab bar -------------------------------------------------------------------

config.use_fancy_tab_bar = USE_FANCY_TAB_BAR
config.tab_max_width = 32
config.colors = {
    tab_bar = {
        background = P.bg_dark,
        active_tab = { bg_color = P.blue, fg_color = P.bg_dark },
        inactive_tab = { bg_color = P.bg_highlight, fg_color = P.comment },
        inactive_tab_hover = { bg_color = P.bg, fg_color = P.fg },
        new_tab = { bg_color = P.bg_dark, fg_color = P.comment },
        new_tab_hover = { bg_color = P.bg_highlight, fg_color = P.fg },
    },
}

local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

-- Processes that mean "nothing is running", so the tab shows the cwd instead.
local SHELLS = { zsh = true, bash = true, sh = true, fish = true, nu = true }

local PROC_ICONS = {
    nvim = I.vim,
    vim = I.vim,
    git = I.git,
    lazygit = I.git,
    cargo = I.rust,
    rustc = I.rust,
    python = I.python,
    python3 = I.python,
    node = I.node,
    npm = I.node,
    docker = I.docker,
    ssh = I.globe,
    make = I.cogs,
    lua = I.lua,
    btop = I.chart,
    htop = I.chart,
    man = I.book,
    claude = I.bolt,
}

local function basename(s)
    return (s:gsub('%.exe$', ''):match('([^/\\]+)$')) or s
end

-- Running process if there is one, else the cwd.
local function tab_label(tab)
    if tab.tab_title and #tab.tab_title > 0 then
        return tab.tab_title, I.tag
    end

    local pane = tab.active_pane
    local proc = basename(pane.foreground_process_name or '')

    if proc ~= '' and not SHELLS[proc] then
        return proc, PROC_ICONS[proc] or I.terminal
    end

    local cwd = pane.current_working_dir
    if cwd then
        local path = (cwd.file_path or tostring(cwd)):gsub('/$', '')
        if path == wezterm.home_dir then
            return '~', I.home
        end
        return basename(path), I.folder
    end

    return pane.title, I.terminal
end

wezterm.on('format-tab-title', function(tab, _, _, _, hover, max_width)
    local label, icon = tab_label(tab)
    local bg = P.bg_highlight
    local fg = P.comment

    if tab.is_active then
        bg, fg = P.blue, P.bg_dark
    elseif hover then
        bg, fg = P.bg, P.fg
    end

    local text = string.format(' %s %d %s ', icon, tab.tab_index + 1, label)
    text = wezterm.truncate_right(text, math.max(max_width - 2, 1)) .. ' '

    if USE_FANCY_TAB_BAR then
        return { { Background = { Color = bg } }, { Foreground = { Color = fg } }, { Text = text } }
    end

    return {
        { Background = { Color = bg } },
        { Foreground = { Color = fg } },
        { Text = text },
        { Background = { Color = P.bg_dark } },
        { Foreground = { Color = bg } },
        { Text = SOLID_RIGHT_ARROW },
    }
end)

-- Left status: the active workspace.
wezterm.on('update-status', function(window, _)
    local name = window:active_workspace()

    window:set_left_status(wezterm.format({
        { Background = { Color = P.magenta } },
        { Foreground = { Color = P.bg_dark } },
        { Attribute = { Intensity = 'Bold' } },
        { Text = ' ' .. I.grid .. ' ' .. name .. ' ' },
        { Background = { Color = P.bg_dark } },
        { Foreground = { Color = P.magenta } },
        { Text = SOLID_RIGHT_ARROW .. ' ' },
    }))
end)

-- Workspaces ----------------------------------------------------------------

-- Immediate subdirectories of PROJECT_ROOT, each offered as a workspace.
local function project_dirs()
    local dirs = {}
    local ok, stdout = wezterm.run_child_process({
        'find', PROJECT_ROOT,
        '-mindepth', '1', '-maxdepth', '1',
        '-type', 'd', '-not', '-name', '.*',
    })
    if not ok then
        return dirs
    end
    for line in stdout:gmatch('[^\n]+') do
        table.insert(dirs, line)
    end
    table.sort(dirs)
    return dirs
end

-- Live workspaces first, then any project dir not already open.
local function workspace_choices()
    local choices = {}
    local seen = {}

    for _, name in ipairs(mux.get_workspace_names()) do
        seen[name] = true
        table.insert(choices, { id = name, label = I.circle .. '  ' .. name })
    end

    for _, dir in ipairs(project_dirs()) do
        local name = basename(dir)
        if not seen[name] then
            table.insert(choices, { id = dir, label = I.folder .. '  ' .. name })
        end
    end

    return choices
end

-- An id that looks like a path spawns a new workspace rooted there;
-- anything else is an existing workspace to switch to.
local function switch_to(window, pane, id)
    if id:sub(1, 1) == '/' then
        window:perform_action(
            act.SwitchToWorkspace({
                name = basename(id),
                spawn = { cwd = id },
            }),
            pane
        )
    else
        window:perform_action(act.SwitchToWorkspace({ name = id }), pane)
    end
end

config.keys = {
    -- Fuzzy-pick a workspace or project.
    {
        key = 'w',
        mods = 'CTRL|SHIFT',
        action = wezterm.action_callback(function(window, pane)
            window:perform_action(
                act.InputSelector({
                    title = 'Workspaces',
                    choices = workspace_choices(),
                    fuzzy = true,
                    fuzzy_description = 'workspace > ',
                    action = wezterm.action_callback(function(win, p, id, _)
                        if id then
                            switch_to(win, p, id)
                        end
                    end),
                }),
                pane
            )
        end),
    },

    -- Create (or jump to) a workspace by name.
    {
        key = 'n',
        mods = 'CTRL|SHIFT',
        action = act.PromptInputLine({
            description = 'New workspace name:',
            action = wezterm.action_callback(function(window, pane, line)
                if line and line ~= '' then
                    window:perform_action(act.SwitchToWorkspace({ name = line }), pane)
                end
            end),
        }),
    },

    -- Cycle through active workspaces.
    { key = '[', mods = 'CTRL|SHIFT', action = act.SwitchWorkspaceRelative(-1) },
    { key = ']', mods = 'CTRL|SHIFT', action = act.SwitchWorkspaceRelative(1) },
}

return config
