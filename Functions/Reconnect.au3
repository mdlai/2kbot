Func isAppsLoaded()
   Return compareCheckSum(30530926,209,121,334,243)
EndFunc
;3130826939,484,51,644,94
Func isTapToPlay()
   Return compareCheckSum(3719735180,172,705,488,829)
EndFunc

Func isDisconnected()
   If isAppsLoaded() or isTapToPlay() or isNetworkError() or Not WinExists("BlueStacks App Player") Then
	  Return True
   Else
	  Return False
   EndIf
EndFunc

Func isNetworkError()
   return compareCheckSum(3488257930,101,409,555,459)
EndFunc

Func runBlueStacks()
   if Not WinExists("BlueStacks App Player") Then
	  Run("C:\Program Files (x86)\BlueStacks\HD-StartLauncher.exe")
	  WinWait("BlueStacks App Player")
	  WinActivate("BlueStacks App Player")
	  sleep(1000)
	  moveBlueStacks()
   EndIf
   initializeBlueStacks()
EndFunc

Func initializeBlueStacks()
   $initializeTimer = 0
   While Not isAppsLoaded() and $initializeTimer < 30
	  sleep(1000)
	  $initializeTimer = $initializeTimer + 1
   WEnd
   If Not isAppsLoaded() Then
	  restartBlueStacks()
   Else
	  runMyNBA()
   EndIf
EndFunc

Func runMyNBA()
   moveBlueStacks()
   $startAttempts = 0
   While isAppsLoaded() and $startAttempts < 6
	  mClick(268,158)
	  sleep(5000)
	  moveBlueStacks()
	  $startAttempts = $startAttempts + 1
   WEnd
   If $startAttempts > 5 Then
	  restartBlueStacks()
   Else
	  WinActivate("BlueStacks App Player")
	  $clientSize = WinGetClientSize("BlueStacks App Player")
	  if Not $clientsize[0] = 657 or Not $clientSize[1] = 1070 Then
		 restartBlueStacks()
	  Else
		 $splashLoading = 0
		 While Not isTapToPlay() and $splashLoading < 35
			sleep(1000)
			$splashLoading = $splashLoading + 1
		 WEnd
		 if isTapToPlay() Then
			menuLogin()
			$initializedCorrectly = True
		 Else
			restartBlueStacks()
		 EndIf
	  EndIf
   EndIf
EndFunc

Func moveBlueStacks()
   WinMove("BlueStacks App Player","",$xpos,$ypos)
EndFunc

Func closeBlueStacks()
   if WinExists("BlueStacks App Player") Then
	  WinClose("BlueStacks App Player")
	  $initilizedCorretly = False
   EndIf
EndFunc

Func restartBlueStacks()
   closeBlueStacks()
   sleep(1000)
   runBlueStacks()
EndFunc