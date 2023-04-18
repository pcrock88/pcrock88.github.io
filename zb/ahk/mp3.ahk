;fileencoding,utf-8
Menu,Tray,Icon,Shell32.dll,138
getlist("https://pcrock88.github.io/zb/ahk/mp3.txt")
	A=% A_ScreenWidth-120
	B=% A_ScreenHeight-96
		Gui,Add,Link,G^!Right xm,<a target="_blank" href="">Next</a> 
		Gui,Add,Link,G^!down xp+36,<a target="_blank" href="">Dwon</a>
		Gui,Add,Link,G^!Left xp+36,<a target="_blank" href="">Exit</a>
		Gui,Color,EEAA99
		Gui,+LastFound -Caption +ToolWindow
		WinSet,TransColor,EEAA99
		gui,show,X%A% Y%B% ;Center A_ScreenHeight
		winset,AlwaysOnTop,,

A1:=StrSplit(version,"`r`n")
play:
;	FileDelete,.\mp3\temp.mp3
	Random,Out,1,A1.MaxIndex()
	A1_1:=StrSplit(A1[Out],",")
	A1_2:=StrSplit(A1_1[1],"-")
;	UrlDownloadToFile,% A1_1[2],.\mp3\temp.mp3
	CoordMode,ToolTip
	ToolTip,% A1_2[1] . " - " . A1_2[2],A_ScreenWidth,A_ScreenHeight-72
	SoundPlay,% A1_1[2],Wait
	GoSub,play

^!Right::SoundPlay,kill
^!Left::
;	FileDelete,.\mp3\temp.mp3
	exitapp
^!Down::FileMove,.\mp3\temp.mp3,% ".\mp3\" . A1_2[1] . " - " . A1_2[2] . ".mp3" ;A_Desktop

getlist(n){
	global version
	whr:=ComObjCreate("WinHttp.WinHttpRequest.5.1")
	whr.Open("GET",n,true)
	whr.Send()
	whr.WaitForResponse()
	version:=whr.ResponseText
}
