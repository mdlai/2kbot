#RequireAdmin

#include "Functions\controlFunctions.au3"
#include "Functions\gamePlay.au3"
#include "Functions\menuMove.au3"
#include "Functions\quickGame.au3"
#include "Functions\season.au3"
#include "Functions\training.au3"
#include "Functions\cardDelete.au3"
;#include "Functions\Reconnect.au3"

;Original Control Window Size (651, 1041)
;Original Window Size(657,1070)

;To Do
;Add function for opening splash incase it backs too far.
;Add lag error checking and rebooting
;add break for no cards to train
;Combine Rares and Superrares
;Destroy Superrares


; ------------------------ Hotkey Setup --------------------------- ;
Dim $Started = False
Dim $Paused
Dim $cardsFull = False

HotKeySet("=","Start")  ;script can START by pressing =
HotKeySet("-", "Pause") ;script can be Pause by pressing -
;HotKeySet("x", "Stop") ;script can be Stopped by pressing x

;HotKeySet("a", "isCardsMax")
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

While(1=1)
   WinMove("BlueStacks App Player","_ctl.Window",$xPos,$yPos)
   if($Started) Then
	  menuGoToQuickGame()
	  While Not $cardsFull
		 quickGameMain()
	  WEnd
	  if $cardsFull Then
		 menuGoToTrain()
		 trainTopCard()
	  EndIf
   EndIf
WEnd