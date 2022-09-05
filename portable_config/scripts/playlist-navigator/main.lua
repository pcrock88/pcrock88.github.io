-- OSD Playlist Navigator
-- OSD 播放列表导航器
-- 项目仓库地址：https://github.com/drogers141/mpv-playlist-navigator
-- 项目作者：Dave Rogers
-- 注释翻译/脚本修改：GreatRunoob
-- see keybindings at bottom for behavior
-- 参考文件末尾的按键绑定内容以了解相应行为

-- Notes
-- 注意
-- line sizing
-- 单行大小
-- the font-size property of the osd scales to the osd resolution dynamically
-- with a font-size of 35 and a 10 line display, all video sizes can generally
-- show all 10 lines
-- osd的字体大小属性会以字体大小为35、显示10行的样式，动态地缩放到osd分辨率上，
-- 所有视频尺寸通常都可以显示10行内容
-- but the method of scrolling for lists > settings.num_lines
-- ensures no matter what you can always see the cursor
-- 但是用于列表滚动的方法 settings.num_lines 可以确保你无论如何都能看到光标

-- search mode - like vim - search results list replaces playlist in viewer
-- 搜索模式，类似于vim，搜索结果列表会替换查看器中原先的播放列表以便选择视频
-- can select video - thus exiting player
-- or can use the 'handle_exit_key' (ESC) to return to the regular playlist
-- 因此选择退出播放器或者使用‘处理退出事件的键位’（ESC）来返回常规的播放列表
-- search playlist scrolls like regular playlist
-- 搜索列表会像常规播放列表那样滚动

local search = require('search_entry')
local pl = require('playlist')

local settings = {
    -- essentially infinity
	-- 本质上应该是（设为）无穷大
    osd_duration_seconds = 600,
}

-- properties manager
-- 属性管理器
-- hold custom properties - save defaults
-- 保留自定义属性，默认调用（内容）保存在文件末尾
-- invocations at bottom of file
local prop_mgr = {
	-- 用于播放列表导航ui的属性设置
    properties = {
        osd_font_size = 30,
        osd_color = "#FFFFFFFF", --ARGB Format
        osd_border_size = 2,
        osd_border_color = "#E0404040", --"#000000"
        osd_back_color = "#E0404040"
    },
	
	-- 用于打印 mpv OSD当前各项属性的ui设置，适用于调试
    defaults = {
        -- commented out are nil by default - (not available to lua yet?)
		-- 注释掉的部分返回值默认为nil
        osd_font_size = mp.get_property_number("osd-font-size"),
        osd_color = "#CCFFFFFF",   --mp.get_property("osd-color"),
        osd_border_size = mp.get_property_number("osd-border-size"),
        osd_border_color = "#CC000000",   --mp.get_property("osd-border-color"),
        osd_back_color = "#00FFFFFF"    --mp.get_property("osd-back-color")
    }
}

local state = {
    saved_cursor_pos = 0,
    in_search_display = false,
    -- like the playlist from mpv, this will be 0-based
	-- 与mpv的播放列表类似，这（search_filtered_playlist）是基于0的索引计数
    -- rows are tuple {playlist-index, filename}
	-- 每行是以元组形式呈现 {播放列表索引, 文件名}
    search_filtered_playlist = {},
    search_term = "n/a"
}

function state:print()
    print(string.format(
            "saved_cursor_pos: %s, in_search_display: %s, #search_filtered_playlist: %s, search_term: %s",
            self.saved_cursor_pos, self.in_search_display, #self.search_filtered_playlist, self.search_term))
end

-- entry point for playlist manager
-- 播放列表管理器入口
function start_playlist_navigator()
    prop_mgr.set_properties()
    pl:init()
    add_keybindings()
    show_playlist()
end

-- main display
-- 主体显示
function show_playlist(duration)
    -- debug
    --pl:print()
    --state:print()
    pl:update()
    if pl.len == 0 then
        return
    end

    if pl.active ~= true then
        pl.active = true
        pl.cursor = pl.pos
        -- debug - show active properties
		-- 调试，显示当前活动的属性
        --prop_mgr.print_defaults()
        --prop_mgr.print_properties()
        --prop_mgr.set_properties()
    end

    -- 正在播放/媒体文件标题
	-- 播放列表/[<ENTER>键载入，<ESC>键退出，</>键搜索]
	output = "Playing: "..mp.get_property('media-title').."\n\n"
    output = output.."Playlist - "..(pl.cursor+1).." / "..pl.len.."        [Enter to load, ESC to quit, / to search]\n"
    output = output..pl:format_lines(pl:get_playlist())
    mp.osd_message(output, (tonumber(duration) or settings.osd_duration_seconds))
end

-- exit from search mode or exit the playlist manager
-- 退出搜索模式或播放列表管理器
function handle_exit_key()
    if state.in_search_display then
        pl.cursor = state.saved_cursor_pos
        state.saved_cursor_pos = 0
        state.in_search_display = false
        state.search_filtered_playlist = {}
        state.search_term = "n/a"
        show_playlist()
    else
        exit_playlist_navigator()
    end
end

-- exit the playlist navigator
-- clear the current context
-- 退出播放列表导航器，清除当前上下文内容
function exit_playlist_navigator()
    mp.osd_message("")
    remove_keybindings()
    prop_mgr.reset_properties()
    pl.active = false
end

-- （选择光标）向上滚动
function scroll_up()
    pl:increment()
    if state.in_search_display then
        show_search_filtered_playlist()
    else
        show_playlist()
    end
end

-- （选择光标）向下滚动
function scroll_down()
    pl:decrement()
    if state.in_search_display then
        show_search_filtered_playlist()
    else
        show_playlist()
    end
end

-- remove file from playlist
-- 从播放列表中移除文件项
function remove_file()
    if pl.len == 0 then return end
    mp.commandv("playlist-remove", pl.cursor)
    pl.cursor = pl.cursor - 1
    if pl.cursor < 0 then pl.cursor = 0 end
    -- reload playlist into playlist data structure
	-- 重新加载播放列表内容至列表数据结构
    pl:init()
    show_playlist()
end

-- 处理enter按键事件
function handle_enter_key()
    if state.in_search_display then
        -- calculate playlist index
		-- 计算播放列表索引
        playlist_index = state.search_filtered_playlist[pl.cursor][1]
        state.in_search_display = false
        load_file(playlist_index)
    else
        load_file(pl.cursor)
    end
end

-- 显示经过搜索过滤后的播放列表
function show_search_filtered_playlist(duration)
    files_only_array = {}
    -- need 0-based array for line formatting
	-- 需要基于0索引计数的数组用于单行的格式化
    for i=0, #state.search_filtered_playlist do
        files_only_array[i] = state.search_filtered_playlist[i][2]
    end
	-- 文件项匹配中
	-- [<ENTER>键载入，<ESC>键返回播放列表]
    output = "Files Matching: "..state.search_term.."\n"
    output = output.."[Enter to load file, ESC to return to playlist]\n"
    output = output..pl:format_lines(files_only_array).."\n"
    mp.osd_message(output, (tonumber(duration) or settings.osd_duration_seconds))
end

-- 在搜索内容输入完成后需要进行的工作
function on_search_input_done()
    state.in_search_display = true
    -- set up iteration for search results
	-- 为搜索结果设置迭代（标识）
    state.saved_cursor_pos = pl.cursor
    -- this cursor is just for the ui formatting
	-- 这个光标仅用于ui格式
    -- the correct index will have to be found if a file is selected
	-- 如果文件被选上了，那么就必须要找到它正确的索引
    pl.cursor = 0
    -- prevents gui from showing a false "currently playing" marker
	-- 防止gui错误地显示“当前正在播放中”的标记
    pl.pos = -1
    state.search_filtered_playlist = pl:filtered_playlist(search.input_string)
    pl.len = #state.search_filtered_playlist + 1
    state.search_term = search.input_string
    for i=0, #state.search_filtered_playlist do
        v = state.search_filtered_playlist[i]
    end
    search.input_string = ""
    show_search_filtered_playlist()
end

-- 进入“搜索输入”模式
function enter_search_input_mode()
    search:enter_input_mode(on_search_input_done)
end

-- load file at playlist_index
-- 在播放列表的索引处加载文件项
-- exits playlist navigator
-- 退出播放列表导航器
function load_file(playlist_index)
    mp.commandv("playlist-play-index", playlist_index)
    exit_playlist_navigator()
end

-- 打印mpv播放列表的属性信息
function print_mpv_playlist_props()
    print("Playlist Properties:")
    local playlist_props = {"playlist-pos", "playlist-current-pos",
    "playlist-playing-pos", "playlist-count"}
    for k, v in pairs(playlist_props) do
        print(v, "=>", mp.get_property(v))
    end
    local count = mp.get_property_number("playlist-count")
    print("Playlist subproperties:")
    for i = 0, count-1 do
        local file = "playlist/"..i.."/filename"
        local id = "playlist/"..i.."/id"
        print(file, " = ", mp.get_property(file))
        print(id, " = ", mp.get_property(id))
    end
end

----------------------------------- KEYBINDINGS ----------------------------------------
------------------------------------ 按键绑定 -----------------------------------------

-- dynamic
-- 动态（绑定）
-- these bindings are added when showing the playlist and removed after
-- 这些按键绑定会在显示播放列表的时候添加（到当前按键映射中），且在退出（播放列表）时移除
-- （这里是根据vim按键习惯进行设置，可自定义）

-- 默认按键绑定设置说明：
-- pgup/k键位用于播放列表和搜索结果列表的向上滚动
-- pgdn/j键位用于播放列表和搜索结果列表的向下滚动
-- enter键位用于从列表中载入当前选项
-- backspace键位用于从列表中移除当前选项
-- esc键位用于退出搜索或播放列表模式
-- /键位用于进入搜索输入模式
function add_keybindings()
    mp.add_forced_key_binding('UP', 'scroll_down', scroll_down, "repeatable")
    mp.add_forced_key_binding('k', 'scroll_down2', scroll_down, "repeatable")

    mp.add_forced_key_binding('DOWN', 'scroll_up', scroll_up, "repeatable")
    mp.add_forced_key_binding('j', 'scroll_up2', scroll_up, "repeatable")

    mp.add_forced_key_binding('ENTER', 'handle_enter_key', handle_enter_key)
    mp.add_forced_key_binding('BS', 'remove_file', remove_file)

    mp.add_forced_key_binding('ESC', 'handle_exit_key', handle_exit_key)
    mp.add_forced_key_binding('/', 'enter_search_input_mode', enter_search_input_mode)
    -- uncomment for debug
	-- 取消（下一行代码）注释用于调试
    --mp.add_forced_key_binding('p','print_mpv_playlist_props', print_mpv_playlist_props)

end

function remove_keybindings()
    mp.remove_key_binding('scroll_down')
    mp.remove_key_binding('scroll_down2')
    mp.remove_key_binding('scroll_up')
    mp.remove_key_binding('scroll_up2')
    mp.remove_key_binding('handle_enter_key')
    mp.remove_key_binding('remove_file')
    mp.remove_key_binding('handle_exit_key')
    mp.remove_key_binding('enter_search_input_mode')
    mp.remove_key_binding('print_mpv_playlist_props')
end

-- static
-- 静态（绑定）
-- added to mpv when you install the script
-- 当你安装这个脚本的时候就会添加到mpv的快捷键中

-- shift+enter键位用于启用播放列表导航器
mp.add_key_binding('SHIFT+ENTER', 'start_playlist_navigator', start_playlist_navigator)


----------------------------------- DISPLAY PROPERTIES ----------------------------------------
---------------------------------- 显示属性信息（调试） ---------------------------------------

function prop_mgr.set_properties()
    mp.set_property("osd-font-size", prop_mgr.properties.osd_font_size)
    mp.set_property("osd-color", prop_mgr.properties.osd_color)
    mp.set_property("osd-border-size", prop_mgr.properties.osd_border_size)
    mp.set_property("osd-border-color", prop_mgr.properties.osd_border_color)
    mp.set_property("osd-back-color", prop_mgr.properties.osd_back_color)
end

function prop_mgr.reset_properties()
    mp.set_property("osd-font-size", prop_mgr.defaults.osd_font_size)
    mp.set_property("osd-color", prop_mgr.defaults.osd_color)
    mp.set_property("osd-border-size", prop_mgr.defaults.osd_border_size)
    mp.set_property("osd-border-color", prop_mgr.defaults.osd_border_color)
    mp.set_property("osd-back-color", prop_mgr.defaults.osd_back_color)
end

function prop_mgr.print_defaults()
    print("Default Properties:")
    for k,v in pairs(prop_mgr.defaults) do
        print(k, "=>", v)
    end
end

function prop_mgr.print_properties()
    print("Set Properties:")
    for k,v in pairs(prop_mgr.properties) do
        print(k, "=>", v)
    end
end

-- not required - just of interest
-- 非必需，仅仅是为了好玩
function print_osd_properties()
    print("OSD Properties")
    local osd_props = {"osd-width", "osd-height", "osd-par", "osd-sym-cc", "osd-ass-cc", "osd-bar", "osd-bar-align-x",
                       "osd-bar-align-y", "osd-bar-w", "osd-bar-h", "osd-font", "osd-font-size", "osd-color", "osd-border-color",
                       "osd-shadow-color", "osd-back-color", "osd-border-size", "osd-shadow-offset", "osd-spacing", "osd-margin-x",
                       "osd-margin-y", "osd-align-x", "osd-align-y", "osd-blur", "osd-bold", "osd-italic", "osd-justify",
                       "force-rgba-osd-rendering", "osd-level", "osd-duration", "osd-fractions", "osd-scale", "osd-scale-by-window",
                       "term-osd", "term-osd-bar", "term-osd-bar-chars", "osd-playing-msg", "osd-status-msg", "osd-msg1", "osd-msg2",
                       "osd-msg3", "video-osd", "osdlevel",
        -- sub-text properties
                       "sub-text", "subfont-text-scale", "sub-text-font", "sub-text-font-size", "sub-text-color", "sub-text-border-color",
                       "sub-text-shadow-color", "sub-text-back-color", "sub-text-border-size", "sub-text-shadow-offset", "sub-text-spacing",
                       "sub-text-margin-x", "sub-text-margin-y", "sub-text-align-x", "sub-text-align-y", "sub-text-blur", "sub-text-bold",
                       "sub-text-italic"}
    for k, v in pairs(osd_props) do
        print(v, "=>", mp.get_property(v))
    end
end
-- prints at invocation of mpv only (no keybinding needed)
-- 仅在调用mpv时打印（没必要绑定键位）
-- （需要此功能的话，请取消下一行代码的注释）
--print_osd_properties()

