;General Mouse Control Functions
Func mClick($xCoord, $yCoord)
   ControlClick("BlueStacks App Player","_ctl.Window","","left",1,$xCoord,$yCoord)
EndFunc

Func shortSpeedClick()
   mClick(646,801)
   sleep(100)
EndFunc

Func mDrag($xStart,$yStart,$xEnd,$yEnd)
   MouseMove($xStart+$xPos,$yStart+$yPos,15)
   sleep(1000)
   MouseDown("left")
   sleep(1000)
   MouseMove($xEnd+$xPos,$yEnd+$yPos,15)
   sleep(1000)
   MouseUp("left")
   sleep(1000)
EndFunc

;Pixel Detection
Func getPixelColor($xC,$yC)    ;Returns Hex truncating the first two digits
   return hex(PixelGetColor($xC + $xPos, $yC + $yPos),6)
EndFunc

Func compareCheckSum($mySum,$myXa,$myYa,$myXb,$myYb)
   if $mySum = PixelChecksum($myXa+$xPos,$myYa+$yPos,$myXb+$xPos,$myYb+$yPos) Then
	  Return True
   Else
	  Return False
   EndIf
EndFunc

Func getPixelCheckSum($myXa,$myYa,$myXb,$myYb)
   Return PixelChecksum($myXa+$xPos,$myYa+$yPos,$myXb+$xPos,$myYb+$yPos)
EndFunc