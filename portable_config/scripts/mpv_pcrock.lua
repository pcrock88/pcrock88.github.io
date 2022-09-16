--最小化时自动暂停
local did_minimize=false mp.observe_property("window-minimized","bool",function(name,value)local pause=mp.get_property_native("pause")if value==true then if pause==false then mp.set_property_native("pause",true)did_minimize=true end elseif value==false then if did_minimize and(pause==true)then mp.set_property_native("pause",false)end did_minimize=false end end)

--播放状态时启用置顶，暂停自动取消置顶
local was_ontop=false mp.observe_property("pause","bool",function(name,value)local ontop=mp.get_property_native("ontop")if value then if ontop then mp.set_property_native("ontop",false)was_ontop=true end else if was_ontop and not ontop then mp.set_property_native("ontop",true)end was_ontop=false end end)

--网络延时重新连接		R
function reload()local path=mp.get_property("path")if path~=nil then local time=mp.get_property_number("time-pos")mp.commandv("loadfile",path,"replace","start="..time)end end
mp.add_key_binding("R", "reload", reload)
