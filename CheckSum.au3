#RequireAdmin
Dim $statColor = 0xF3C50B
;Original Control Window Size (651, 1041)
;Original Window Size(657,1070)

;~ ;Do
;Card Destroyer total reward count
; ------------------------ Hotkey Setup --------------------------- ;
Dim $Started = False
Dim $Paused
Dim $CursorInfoFirst
Dim $CursorInfoSecond

;HotKeySet("a", "playQuickGame")
HotKeySet("1", "getMouseOne")
HotKeySet("2", "getMouseTwo")
HotKeySet("3", "getMouseCheckSum")
HotKeySet("4","getFixedCheckSum")

AutoItSetOption("MouseCoordMode",0)
AutoItSetOption("PixelCoordMode",1)
$xPos = 3120
$yPos = 0


Func Pause()
   $paused = NOT $paused
   While $paused
        sleep(100)
   WEnd
EndFunc

Func Stop() ;to allow the script to stop
    Exit
EndFunc

Func Start()
    $Started = True
 EndFunc

;--------------------------------------------------------------------- ;
; ------------------------ Main Loop --------------------------- ;
;--------------------------------------------------------------------- ;
;$runcount = 0
While(1=1)
   WinMove("BlueStacks App Player","_ctl.Window",$xPos,$yPos)
   if($Started) Then
	getCheckSum()
   EndIf
WEnd
;1284327121 189 34 229 85

;515211924 388 125 525 148
;553578395 472 129 523 147
Func getFixedCheckSum()
   $check = PixelChecksum(388+$xPos,125+$yPos,525+$xPos,148+$yPos)
   MsgBox(0,"",$check)
EndFunc

Func getMouseOne()
   $CursorInfoFirst = MouseGetPos()
EndFunc

Func getMouseTwo()
   $CursorInfoSecond = MouseGetPos()
EndFunc

Func getMouseCheckSum()
   $check = PixelChecksum($CursorInfoFirst[0]+$xPos,$CursorInfoFirst[1]+$yPos,$CursorInfoSecond[0]+$xPos,$CursorInfoSecond[1]+$yPos)
   ClipPut($check & "," & $CursorInfoFirst[0]& "," &$CursorInfoFirst[1]& "," &$CursorInfoSecond[0]& "," &$CursorInfoSecond[1])
   MsgBox(0,"",$check & "," & $CursorInfoFirst[0]& "," &$CursorInfoFirst[1]& "," &$CursorInfoSecond[0]& "," &$CursorInfoSecond[1])
EndFunc