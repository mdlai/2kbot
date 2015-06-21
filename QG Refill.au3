#RequireAdmin

#include "Functions\controlFunctions.au3"
#include "Functions\gamePlay.au3"
#include "Functions\menuMove.au3"
#include "Functions\quickGame.au3"
#include "Functions\season.au3"
#include "Functions\training.au3"

;Original Control Window Size (651, 1041)
;Original Window Size(657,1070)

;To Do
;Add function for opening splash incase it backs too far.
;Break up script into multiple files
;Add lag error checking and rebooting


; ------------------------ Hotkey Setup --------------------------- ;
Dim $Started = False
Dim $Paused
Dim $cardsFull = False

HotKeySet("=","Start")  ;script can START by pressing =
HotKeySet("-", "Pause") ;script can be Pause by pressing -
;HotKeySet("x", "Stop") ;script can be Stopped by pressing x

;HotKeySet("a", "energyRefill")
;HotKeySet("c", "menuMyTeamMobile")
;HotKeySet("d", "menuBack")
;HotKeySet("e", "menuPinSeason")


AutoItSetOption("MouseCoordMode",1)
AutoItSetOption("PixelCoordMode",1)
$xPos = 3120
$yPos = 0
;$totalRewards


Func Pause()
   $paused = NOT $paused
   While $paused
        sleep(100)
   WEnd
EndFunc

Func Stop()
    Exit
EndFunc

Func Start()
    $Started = True
 EndFunc

;-------------------------------MAIN-------------------------------------- ;
; ------------------------ Main Loop --------------------------- ;
;--------------------------------------------------------------------- ;
Dim $roundTime = TimerInit()
$oneHour = 3600000
$waitHours = .98
$totalWaitTime = ($oneHour * $waitHours)
While(1=1)
   WinMove("BlueStacks App Player","_ctl.Window",$xPos,$yPos)
   if($Started) Then
	  If Not $cardsFull and TimerDiff($roundTime) < $totalWaitTime Then
		 menuGoToQuickGame()
	  EndIf
	  While Not $cardsFull and TimerDiff($roundTime) < $totalWaitTime
		 quickGameMain()
	  WEnd
	  If $cardsFull Then
		 menuGoToTrain()
		 trainTopCard()
	  ElseIf TimerDiff($roundTime) > $totalWaitTime Then
		 $roundTime = TimerInit()
		 menuGoToManageSeason()
		 energyRefill()
	  EndIf
   EndIf
WEnd