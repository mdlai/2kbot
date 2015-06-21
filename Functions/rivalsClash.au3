Func isRivalsClashMenu()
   if compareCheckSum(2271566809,215,538,432,573) and compareCheckSum(3972290707,338,34,632,82) Then ;PlayForTeam,  Clash with house icon
	  Return True
   Else
	  Return False
   EndIf
EndFunc

Func isRivalsClashOpponent()
   if compareCheckSum(4144278853,27,319,205,342) or compareCheckSum(770642521,463,316,623,342) or compareCheckSum(661461255,72,983,130,1025) Then ;Ladder Rewards,  Edit Lineup, +5
	  Return True
   Else
	  Return False
   EndIf
EndFunc

Func isRivalsClashPlay() ;In Game
   if compareCheckSum(2720938459,106,893,129,902) or compareCheckSum(865982181,499,892,520,904) Then; or compareCheckSum(127296137,338,36,643,77) Then ;PG check, C check, Name Check, Clash in rivals clash
	  Return True
   Else
	  Return False
   EndIf
EndFunc

Func isRivalsClashQuarterShowing()
   if compareCheckSum(2681808016,300,402,353,425) or compareCheckSum(476932805,302,404,351,438) Then ;QTR on scoreboard
	  Return True
   Else
	  Return False
   EndIf
EndFunc

Func isHotStreak()
   if compareCheckSum(1610591412,89,542,124,572) Then ;hotstreak is 1
	  Return True
   Else
	  Return False
   EndIf
EndFunc

Func isBottomSafe()
   if compareCheckSum(4291589183,237,992,374,1018)Then;Finisher compareCheckSum(4014935876,233,991,376,1014) Then
	  Return True
   Else
	  Return False
   EndIf

   ;return compareCheckSum(4014935876,233,991,376,1014) ;Finisher Jason7Stars1194590209,2498,637,2714,664   28292217,247,815,362,842
EndFunc

Func isMiddleSafe()
   return compareCheckSum(3055832483,231,814,376,844)
EndFunc

;Control Functions
Func menuPlayForYourTeam()
   mClick(580,551)
   sleep(800)
EndFunc

Func launchRivalsClash()
   mClick(104,982) ;+5 point
   ;mClick(307,831) ;+3 point
EndFunc

Func clickHotStreak()
   sleep(200)
   mClick(127,520)
   sleep(500)
EndFunc

Func getNewOpponent()
   mClick(39,33)
   $resetBreak = 0
   While not isRivalsClashMenu() and $resetBreak < 50
	  Sleep(100)
	  $resetBreak = $resetBreak + 1
   WEnd
   menuPlayForYourTeam()
   $resetBreak = 0
   While not isRivalsClashOpponent() and Not compareCheckSum(661461255,72,983,130,1025) and $resetBreak < 100
	  Sleep(100)
	  $resetBreak = $resetBreak + 1
	  if $resetBreak > 98 and isRivalsClashOpponent() and Not compareCheckSum(661461255,72,983,130,1025) Then
		 getNewOpponent()
	  EndIf
   WEnd
EndFunc

;RC Functions
Func rivalsClashGameMain()
   if isRivalsClashMenu() Then
	  menuPlayForYourTeam()
   ElseIf isMainMenu() Then
	  menuGoToRivalsClash()
   Else
	  While Not isRivalsClashMenu() and Not isMainMenu() ;and Not isDisconnected()
		 If isRivalsClashOpponent() Then
			launchRivalsClash()
			If isCardsMax() Then
			   clickOK()
			   sleep(1000)
			   $cardsFull = True
			   ExitLoop
			EndIf
		 ElseIf isRivalsClashPlay() Then
			RivalsClashGame()
		 ElseIf isRewardsChoose() Then
			getReward()
		 ElseIf isRewardsProceed() Then
			getProceed()
		 Else
			mClick(641,463)
			sleep(100)
		 EndIf
	  WEnd
   EndIf
EndFunc
;Avoid the center, if PG play C mumu
Func RivalsClashGame()
   ;Local $playerStats[5][5] = [[827,903,26,2,825],[813,840,55,27,833],[764,778,24,11,862],[845,825,59,6,773],[809,844,61,42,778]] ;3epic
   ;Local $playerStats[5][5] = [[1729,1642,60,1567,50],[1515,1620,55,1638,48],[1450,1489,24,1638,11],[1563,1528,20,1475,57],[1554,1534,57,1532,57]] ;3leg
   Local $playerStats[5][5] = [[1729,1642,2426,1567,2664],[1515,1620,2255,1571,2479],[1450,1589,2224,1638,2428],[1563,1528,2259,1475,2342],[1554,1534,2261,1532,2481]] ;Full Lineup
   ;Local $playerStats[5][5] = [[1729,1642,142,1567,266],[1515,1620,125,1571,247],[1450,1589,122,1638,242],[1563,1528,125,1475,234],[1554,1534,126,1532,248]]
   Local $breakCount = 0

   ;Local $playerStats[5][5] = [[1698,70,1642,1567,60],[1542,56,1630,1571,60],[1497,54,1489,1648,65],[1638,57,1528,1475,53],[1581,57,1534,1532,57]]
   $sandBagOne = False
   $sandBagTwo = False
   $sandBagPlayerOne = 3
   $sandBagPlayerTwo = 2
   $playerPos = -1
   While isRivalsClashPlay() and isRivalsClashQuarterShowing() and $breakCount < 5 ;while isquickgameplay()
	  if $breakCount = 0 Then
		 sleep(100)
		 clickPowerBottom()
	  EndIf
	  sleep(75)
	  Local $roundStat = getStat()
	  ;tooltip(isScoreTied(),1920,0)
	  if $breakCount = 0 and $sandBagOne Then;isOpponentOffense() and $sandBag and $roundStat[0]<>1 Then ;sandbag if they're on offense and i'm not
		 $playerPos = $sandBagPlayerOne
		 $playerStats = statChange($playerStats,$playerPos)
		 $sandBagOne = False
	  ElseIf $breakCount = 2 and $SandBagTwo and isScoreTied() Then ;
		 $playerPos = $sandBagPlayerTwo
		 $playerStats = statChange($playerStats,$playerPos)
		 $sandBagTwo = False
	  Else
		 $playerPos = statCheck($playerStats)
		 $playerStats = statChange($playerStats,$playerPos)
		 if $playerPos = $sandBagPlayerOne Then
			$sandBagOne = False
		 ElseIf $playerPos = $sandBagPlayerTwo Then
			$sandBagTwo = False
		 EndIf
	  EndIf
	  For $i = 1 to 8
		 playerClick($playerPos)
	  Next
	  $clickBreak = 0
	  While (isRivalsClashPlay() or compareCheckSum(127296137,338,36,643,77)) and Not isRivalsClashQuarterShowing() and $clickBreak < 150
		 playerClick($playerPos)
		 $clickBreak = $clickBreak + 1
	  WEnd
	  $breakCount = $breakCount + 1
   WEnd
EndFunc



#cs

		 #ce
