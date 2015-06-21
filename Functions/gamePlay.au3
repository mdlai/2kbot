;Rewards Checking
Func isRewardsChoose()
   if compareCheckSum(3500947316,371,926,409,989) or compareCheckSum(2025417527,369,925,408,984) or compareCheckSum(752414516,373,929,407,983) Then ;When card is showing, when card isn't showing, not sure
	  Return True
   Else
	  Return False
   EndIf
EndFunc

Func isRewardsProceed()
   if compareCheckSum(4248983408,323,925,428,973) or compareCheckSum(682944121,321,923,427,972) Then
	  Return True
   Else
	  Return False
   EndIf
EndFunc

Func isEnergyFull()
   Return compareCheckSum(3654356254,277,487,445,526)
EndFunc

Func isCardsMax()
   return compareCheckSum(2985317701,259,406,581,529)
EndFunc

Func isBoostsMax()
   if compareCheckSum(831032946,322,386,535,429) or compareCheckSum(3793300575,268,486,471,529) Then
	  Return True
   Else
	  Return False
   EndIf
EndFunc

Func isOpponentOffense()
   If getPixelColor(409,655) = "FFF0FF" and getPixelColor(409,665) = "FFF0FF" and getPixelColor(423,659) = "FFF0FF" and getPixelColor(441,659) = "FFF0FF" and getPixelColor(473,655) = "FFF0FF" and getPixelColor(501,653) = "FFF0FF" and getPixelColor(509,649) = "FFF0FF" and getPixelColor(427,669) <> "FFF0FF" Then
	  Return True
   ElseIf getPixelColor(410,634) = "FFF0FF" and getPixelColor(410,644) = "FFF0FF" and getPixelColor(428,638) = "FFF0FF" and getPixelColor(445,638) = "FFF0FF" and getPixelColor(463,647) = "FFF0FF" and getPixelColor(475,634) = "FFF0FF" and getPixelColor(494,636) = "FFF0FF" and getPixelColor(427,647) <> "FFF0FF" Then
	  Return True
   Else
	  Return False
   EndIf
EndFunc

;In Gameplay Control Functions
Func clickProceed()
   sleep(200)
   mClick(321,971)
   sleep (500)
EndFunc

Func clickOK()
   mClick(488,732)
   sleep(200)
EndFunc

Func clickPG()
   mClick(82,940)
   sleep(200)
EndFunc

Func clickSG()
   mClick(204,967)
   sleep(200)
EndFunc

Func clickSF()
   mClick(300,967)
   sleep(200)
EndFunc

Func clickPF()
   mClick(389,940)
   sleep(200)
EndFunc

Func clickC()
   mClick(467,926)
   sleep(200)
EndFunc

Func clickPowerTop()
   mClick(600,929)
   sleep(250)
EndFunc

Func clickPowerBottom()
   mClick(600,970)
   sleep(250)
EndFunc

Func playerClick($pos)
   If $pos = 0 Then
	  clickPG()
   ElseIf $pos = 1 Then
	  clickSG()
   ElseIf $pos = 2 Then
	  clickSF()
   ElseIf $pos = 3 Then
	  clickPF()
   ElseIf $pos = 4 Then
	  clickC()
   EndIf
EndFunc

Func getReward()
   ;top left black 59 115    dx115 dy143
   ;bottom right 520 686 0x000000

   $cardX = 94
   $cardY = 150
   $cardDx = 116
   $cardDy = 142

   For $i = 0 to 4 Step 1
	  For $j = 0 to 4 Step 1
			If Not isRewardsChoose() Then
			   ExitLoop 2
			ElseIf isBoostsMax() or isEnergyFull() Then
			   clickOK()
			ElseIf getPixelColor(59 + (115*$i),115 + (143*$j)) = "000000" Then
			   sleep(50)
			   mClick($cardX + ($cardDx*$i), $cardY + ($cardDy*$j))
			   sleep(200)
			   shortSpeedClick()
			   sleep(200)
			   shortSpeedClick()
			   sleep(200)
			   shortSpeedClick()
			EndIf
	  Next
   Next
   shortSpeedClick()
EndFunc

Func getProceed()
   if isCardsMax() Then
	  sleep(1000)
	  clickOK()
	  $cardsFull = True
	  clickProceed()
   ElseIf isBoostsMax() or isEnergyFull() Then
	  clickOK()
	  sleep(1000)
	  clickProceed()
   Else
	  clickProceed()
   EndIf
EndFunc

   ;QuickGame Stat Decisions
Func getStat()
   ;Top Left Coords and change Coords
   $pgStat = 108
   $offY = 919
   $dXstat = 98
   $dYstat = 20

   Local $activeStat[5]
   For $j = 0 to 4 Step 1
	  For $i = 0 To 4 Step 1
		 If getPixelColor($pgStat + ($dXstat*$i), $offY+($dYstat*$j)) = "F3C50B" or getPixelColor($pgStat + ($dXstat*$i), $offY+($dYstat*$j)) = "BD9914" Then
			$activeStat[$j] = 1
			ExitLoop
		 Else
			$activeStat[$j] = .01
		 EndIf
	  Next
   Next
   Return $activeStat
EndFunc

Func statChange($statGrid,$playerPos)
   For $h = 0 to 4 step 1
	  $statGrid[$h][$playerPos] = 0
   Next
   Return $statGrid
EndFunc

Func statCheck($statGrid)
   $playerPos = 0
   $totalStat = 0
   $bestStat = 0

   Local $currStats = getStat()

   ;MsgBox("","",$currStats[0]&$currStats[1]&$currStats[2]&$currStats[3]&$currStats[1])

   For $j = 0 to 4 step 1
	  For $k = 0 to 4 step 1
		 $totalStat = $currStats[$k] * $statGrid[$k][$j] + $totalStat
	  Next
	  ;MsgBox("","",$totalStat)
	  If $totalStat > $bestStat Then
		 $bestStat = $totalStat
		 $playerPos = $j
	  EndIf
	  $totalStat = 0
   Next

   Return $playerPos
EndFunc

Func getOpponentPos()
   if compareCheckSum(1764378628,577,189,617,211) Then
	  tooltip(0,1920,0)
	  Return 0
   ElseIf compareCheckSum(2332351988,471,189,511,209) Then
	  tooltip(1,1920,0)
	  Return 1
   ElseIf compareCheckSum(4142943785,363,191,402,210) Then
	  tooltip(2,1920,0)
	  Return 2
   ElseIf compareCheckSum(3824373551,255,191,294,210) Then
	  tooltip(3,1920,0)
	  Return 3
   ElseIf compareCheckSum(3578689521,148,191,186,211) Then
	  tooltip(4,1920,0)
	  Return 4
   Else
	  tooltip(6,1920,0)
	  Return 6
   EndIf
EndFunc

Func isScoreTied()
   $opponentScoreX = 31
   $opponentScoreY = 396
   $myScoreX = 28
   $myScoreY = 765
   $dCount = 0
   For $i = 0 to 60 Step 1
	  If (getPixelColor($opponentScoreX + $i,$opponentScoreY) = "333333" and getPixelColor($myScoreX + $i,$myScoreY) = "333333") or (getPixelColor($opponentScoreX + $i,$opponentScoreY) <> "333333" and getPixelColor($myScoreX + $i,$myScoreY) <> "333333") Then
		 ;MsgBox(0,"",getPixelColor($opponentScoreX + $i,$opponentScoreY) & ", " & getPixelColor($myScoreX + $i,$myScoreY))
		 $dCount = $dCount
	  Else
		 ;MsgBox(0,"",getPixelColor($opponentScoreX + $i,$opponentScoreY) & ", " & getPixelColor($myScoreX + $i,$myScoreY) & ", " & $i)
		 $dCount = $dCount + 1
	  EndIf
   Next
   ;MsgBox(0,"",$dCount)
   ;tooltip($dcount,1920,0)
   If $dCount < 5 Then
	  Return True
   Else
	  Return False
   EndIf

   ;Return $dCount
EndFunc