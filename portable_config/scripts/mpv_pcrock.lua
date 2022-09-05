--打开文件
utils = require 'mp.utils'
function open_file_dialog()
	local was_ontop = mp.get_property_native("ontop")
	if was_ontop then mp.set_property_native("ontop", false) end
	local res = utils.subprocess({
		args = {'powershell', '-NoProfile', '-Command', [[& {
			Trap {
				Write-Error -ErrorRecord $_
				Exit 1
			}
			Add-Type -AssemblyName PresentationFramework
			$u8 = [System.Text.Encoding]::UTF8
			$out = [Console]::OpenStandardOutput()
			$ofd = New-Object -TypeName Microsoft.Win32.OpenFileDialog
			$ofd.Multiselect = $true
			If ($ofd.ShowDialog() -eq $true) {
				ForEach ($filename in $ofd.FileNames) {
					$u8filename = $u8.GetBytes("$filename`n")
					$out.Write($u8filename, 0, $u8filename.Length)
				}
			}
		}]]},
		cancellable = false,
	})
	if was_ontop then mp.set_property_native("ontop", true) end
	if (res.status ~= 0) then return end

	local first_file = true
	for filename in string.gmatch(res.stdout, '[^\n]+') do
		mp.commandv('loadfile', filename, first_file and 'replace' or 'append')
		first_file = false
	end
end
mp.add_key_binding('ctrl+o', 'open-file-dialog', open_file_dialog)


--最小化时自动暂停
local did_minimize = false
mp.observe_property("window-minimized", "bool", function(name, value)
    local pause = mp.get_property_native("pause")
    if value == true then
        if pause == false then
            mp.set_property_native("pause", true)
            did_minimize = true
        end
    elseif value == false then
        if did_minimize and (pause == true) then
            mp.set_property_native("pause", false)
        end
        did_minimize = false
    end
end)

--播放状态时启用置顶，暂停自动取消置顶
local was_ontop = false
mp.observe_property("pause", "bool", function(name, value)
    local ontop = mp.get_property_native("ontop")
    if value then
        if ontop then
            mp.set_property_native("ontop", false)
            was_ontop = true
        end
    else
        if was_ontop and not ontop then
            mp.set_property_native("ontop", true)
        end
        was_ontop = false
    end
end)

--网络延时重新连接
function reload()
    local path = mp.get_property("path")
    if path ~= nil then
        local time = mp.get_property_number("time-pos")
        mp.commandv("loadfile", path, "replace", "start=" .. time)
    end
end
mp.add_key_binding("R", "reload", reload)

--自动加载文件
MAXENTRIES = 5000
local msg = require 'mp.msg'
local options = require 'mp.options'
local utils = require 'mp.utils'
o = {
    disabled = false,		--false or true
    images = true,		--false or true
    videos = true,		--false or true
    audio = true,		--false or true
    ignore_hidden = true		--false or true
}
options.read_options(o)
function Set (t)
    local set = {}
    for _, v in pairs(t) do set[v] = true end
    return set
end
function SetUnion (a,b)
    local res = {}
    for k in pairs(a) do res[k] = true end
    for k in pairs(b) do res[k] = true end
    return res
end
EXTENSIONS_VIDEO = Set {
    'mkv', 'avi', 'mp4', 'ogv', 'webm', 'rmvb', 'flv', 'wmv', 'mpeg', 'mpg', 'm4v', '3gp'
}
EXTENSIONS_AUDIO = Set {
    'mp3', 'wav', 'ogm', 'flac', 'm4a', 'wma', 'ogg', 'opus'
}
EXTENSIONS_IMAGES = Set {
    'jpg', 'jpeg', 'png', 'tif', 'tiff', 'gif', 'webp', 'svg', 'bmp'
}
EXTENSIONS = Set {}
if o.videos then EXTENSIONS = SetUnion(EXTENSIONS, EXTENSIONS_VIDEO) end
if o.audio then EXTENSIONS = SetUnion(EXTENSIONS, EXTENSIONS_AUDIO) end
if o.images then EXTENSIONS = SetUnion(EXTENSIONS, EXTENSIONS_IMAGES) end
function add_files_at(index, files)
    index = index - 1
    local oldcount = mp.get_property_number("playlist-count", 1)
    for i = 1, #files do
        mp.commandv("loadfile", files[i], "append")
        mp.commandv("playlist-move", oldcount + i - 1, index + i - 1)
    end
end
function get_extension(path)
    match = string.match(path, "%.([^%.]+)$" )
    if match == nil then
        return "nomatch"
    else
        return match
    end
end
table.filter = function(t, iter)
    for i = #t, 1, -1 do
        if not iter(t[i]) then
            table.remove(t, i)
        end
    end
end
function splitbynum(s)
    local result = {}
    for x, y in (s or ""):gmatch("(%d*)(%D*)") do
        if x ~= "" then table.insert(result, tonumber(x)) end
        if y ~= "" then table.insert(result, y) end
    end
    return result
end
function clean_key(k)
    k = (' '..k..' '):gsub("%s+", " "):sub(2, -2):lower()
    return splitbynum(k)
end
function alnumcomp(x, y)
    local xt, yt = clean_key(x), clean_key(y)
    for i = 1, math.min(#xt, #yt) do
        local xe, ye = xt[i], yt[i]
        if type(xe) == "string" then ye = tostring(ye)
        elseif type(ye) == "string" then xe = tostring(xe) end
        if xe ~= ye then return xe < ye end
    end
    return #xt < #yt
end
local autoloaded = nil
function find_and_add_entries()
    local path = mp.get_property("path", "")
    local dir, filename = utils.split_path(path)
    msg.trace(("dir: %s, filename: %s"):format(dir, filename))
    if o.disabled then
        msg.verbose("stopping: autoload disabled")
        return
    elseif #dir == 0 then
        msg.verbose("stopping: not a local path")
        return
    end

    local pl_count = mp.get_property_number("playlist-count", 1)
    if (pl_count > 1 and autoloaded == nil) or
       (pl_count == 1 and EXTENSIONS[string.lower(get_extension(filename))] == nil) then
        msg.verbose("stopping: manually made playlist")
        return
    else
        autoloaded = true
    end

    local pl = mp.get_property_native("playlist", {})
    local pl_current = mp.get_property_number("playlist-pos-1", 1)
    msg.trace(("playlist-pos-1: %s, playlist: %s"):format(pl_current,
        utils.to_string(pl)))

    local files = utils.readdir(dir, "files")
    if files == nil then
        msg.verbose("no other files in directory")
        return
    end
    table.filter(files, function (v, k)
        if (o.ignore_hidden and not (v == filename) and string.match(v, "^%.")) then
            return false
        end
        local ext = get_extension(v)
        if ext == nil then
            return false
        end
        return EXTENSIONS[string.lower(ext)]
    end)
    table.sort(files, alnumcomp)

    if dir == "." then
        dir = ""
    end
    local current
    for i = 1, #files do
        if files[i] == filename then
            current = i
            break
        end
    end
    if current == nil then
        return
    end
    msg.trace("current file position in files: "..current)
    local append = {[-1] = {}, [1] = {}}
    for direction = -1, 1, 2 do -- 2 iterations, with direction = -1 and +1
        for i = 1, MAXENTRIES do
            local file = files[current + i * direction]
            local pl_e = pl[pl_current + i * direction]
            if file == nil or file[1] == "." then
                break
            end
            local filepath = dir .. file
            if pl_e then
                msg.trace(pl_e.filename.." == "..filepath.." ?")
                if pl_e.filename == filepath then
                    break
                end
            end
            if direction == -1 then
                if pl_current == 1 then -- never add additional entries in the middle
                    msg.info("Prepending " .. file)
                    table.insert(append[-1], 1, filepath)
                end
            else
                msg.info("Adding " .. file)
                table.insert(append[1], filepath)
            end
        end
    end
    add_files_at(pl_current + 1, append[1])
    add_files_at(pl_current, append[-1])
end
mp.register_event("start-file", find_and_add_entries)

--Boss KEY
utils = require 'mp.utils'
local platform = nil --set to 'linux', 'windows' or 'macos' to override automatic assign
if not platform then
    local o = {}
    if mp.get_property_native('options/vo-mmcss-profile', o) ~= o then
        platform = 'windows'
    elseif mp.get_property_native('options/input-app-events', o) ~= o then
        platform = 'macos'
    else
        platform = 'linux'
    end
end
function boss_key()
	mp.set_property_native("pause", true)
	if platform == 'windows' then
	    mp.command([[run cmd /c echo m > \\.\pipe\mpv-boss-key-]]..utils.getpid())
	elseif platform == 'linux' then
	    utils.subprocess({ args = {'xdotool', 'getactivewindow', 'windowminimize'} })
	end
end
if platform == 'windows' then
    mp.command_native_async({
        name = "subprocess",
        playback_only = false,
        detach = true,
        args = {'powershell', '-NoProfile', '-Command', [[&{
$bosspid = ]]..utils.getpid()..[[
# Construct the named pipe's name
$pipename = -join('mpv-boss-key-',$bosspid)
$fullpipename = -join("\\.\pipe\", $pipename)
# This will run in a separate thread
$minimizeloop = {
    param($pipename, $bosspid)
    # Create the named pipe
    $pipe = new-object System.IO.Pipes.NamedPipeServerStream($pipename)
    # Compile the Win32 API function call
    $signature='[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);'
    $showWindowAsync = Add-Type -memberDefinition $signature -name "Win32ShowWindowAsync" -namespace Win32Functions -passThru
    # The core loop
    while($true) {
        $pipe.WaitForConnection()
        if ($pipe.ReadByte() -ne 109) {
            break 
        }
        $pipe.Disconnect()
        $showWindowAsync::ShowWindowAsync((Get-Process -id $bosspid).MainWindowHandle, 2)
    }
    $pipe.Dispose()
}
# Exiting this monstrosity (THANKS POWERSHELL FOR BROKEN ASYNC) is surprisingly
# cumbersome. It took literal hours to find something that didn't spontaneously
# combust.
$bossproc = Get-Process -pid $bosspid -ErrorAction SilentlyContinue
$exitsequence = {
    &{echo q > $fullpipename} 2> $null
    [Environment]::Exit(0)
}
if ((-Not $bossproc) -or $bossproc.HasExited) { $exitsequence.Invoke() }
# Begin watching for events until boss closes
Start-Job -ScriptBlock $minimizeloop -Name "mpvminloop" -ArgumentList $pipename,$bosspid
while($true) {
    Start-Sleep 1
    if ($bossproc.HasExited) { $exitsequence.Invoke() }
}
}]]}}, function()end)
end
mp.add_key_binding('Alt+`', 'boss-key', boss_key)
