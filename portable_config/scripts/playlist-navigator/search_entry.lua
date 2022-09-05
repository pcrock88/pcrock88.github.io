-- Handles search entry input
-- 处理搜索入口的输入内容

-- Search is case insensitive
-- 搜索是不区分大小写的（对大小写不敏感）
-- Search term can contain any characters from AVAILABLE_INPUT_CHARS below
-- 搜索词可以是包含在以下 AVAILABLE_INPUT_CHARS 当中的任意字符
-- essentially this is an osd prompt dialog
-- 本质上这是一个osd提示对话框

-- table to be exported
-- 待导出的表格
local search = {
    -- function to call when user finishes entering input
	-- 当用户结束输入时需要被调用的函数
    finished_callback = nil
}

-- characters handled for inputting search
-- （允许）用于搜索输入内容处理的字符集
AVAILABLE_INPUT_CHARS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ012345689-_.*%?+[]()"

local settings = {
    osd_duration_seconds = 600
}
-- user entered search string
-- 用户输入的搜索字符串
search.input_string = ""

-- entry into search mode
-- 进入搜索模式
-- input search term
-- 输入搜索词
function search:enter_input_mode(callback)
	-- 函数回调
    self.finished_callback = callback
    add_search_keybindings()
    self:show_input()
end

-- 显示输入的（搜索）内容
function search:show_input(duration)
	-- 搜索：<input>
    input_line = "Search: "..self.input_string
    mp.osd_message(input_line, (tonumber(duration) or settings.osd_duration_seconds))
end

-- 处理搜索模式下enter事件
function handle_search_enter()
    remove_search_keybindings()
    search.finished_callback()
end

-- 处理搜索模式下esc事件
function handle_search_escape()
    remove_search_keybindings()
end

-- 处理backspace事件（搜索/导航模式通用）
function handle_backspace()
    if search.input_string == "" then
        return
    end
    search.input_string = string.sub(search.input_string, 1, -2)
    search:show_input()
end

-- 处理输入事件
function handle_input(char)
    search.input_string = search.input_string..char
    search:show_input()
end

local SEARCH_BINDINGS = {}

-- 添加搜索模式下的键位绑定
function add_search_keybindings()
    local bindings = {
        {'BS', handle_backspace},
        {'ENTER', handle_search_enter},
        {'ESC', handle_search_escape},
		-- 允许在搜索词中添加空格
        {'SPACE', function() handle_input(' ') end}
    }
	
	-- 所有允许使用的功能和字符集都将被绑定到对应的键位
	-- 例如允许输入的字符集全部绑定至自身键位，并触发 handle_input 事件
	-- 调用 show_input 从而实现输入内容的实时显示
    for ch in AVAILABLE_INPUT_CHARS:gmatch"." do
        bindings[#bindings + 1] = {ch, function() handle_input(ch) end}
    end
    for i, binding in ipairs(bindings) do
        local key = binding[1]
        local func = binding[2]
        local name = '__search_binding_' .. i
        SEARCH_BINDINGS[#SEARCH_BINDINGS + 1] = name
        mp.add_forced_key_binding(key, name, func, "repeatable")
    end
end

-- 移除所有的搜索键位绑定
function remove_search_keybindings()
    for i, key_name in ipairs(SEARCH_BINDINGS) do
        mp.remove_key_binding(key_name)
    end
end


return search
