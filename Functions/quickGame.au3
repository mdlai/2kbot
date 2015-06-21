;GameState
Func isQuickGamePlay() ;In Game
   if compareCheckSum(1692281786,99,891,133,903) or compareCheckSum(1454481985,493,890,517,902) or compareCheckSum(713768592,15,829,34,870) or compareCheckSum(824226157,337,36,636,81) Then ;PG check, C check, Name Check, Game in quickgame
	  Return True
   Else
	  Return False
   EndIf
EndFunc

Func isQuickGameQuarterShowing()
   if compareCheckSum(2754097934,365,717,508,741) and compareCheckSum(541086865,323,410,325,425) Then ;M in michael, Choose One Player, Yellow In QTR
	  Return True
   Else
	  Return False
   EndIf
EndFunc

Func isQuickGameOpponent() ;Select Opponent
   if compareCheckSum(2980738340,520,316,620,340) or compareCheckSum(3720724268,337,36,636,81) Then ;edit lineup check,  Game with house icon
	  Return True
   Else
	  Return False
   EndIf
EndFunc

Func isTopSafe()
   if compareCheckSum(2623824223,252,516,393,550) Then ;Finisher
	  Return True
   Else
	  Return False
   EndIf
EndFunc

Func isMiddleSafe()
   if compareCheckSum(2794621752,251,686,399,718) Then ;Finisher
	  Return True
   Else
	  Return False
   EndIf
EndFunc

Func isBottomSafe()
   if compareCheckSum(52916811,249,858,403,895) Then ;Finisher
	  Return True
   Else
	  Return False
   EndIf
EndFunc

Func isLastSafe()
   if compareCheckSum(4003392760,247,1024,362,1041) Then ;Finisher
	  Return True
   Else
	  Return False
   EndIf
EndFunc

;Control Functions
Func launchQuickGame()
   #cs
   sleep(300)
   If isTopSafe() Then
	  mClick(307,523)
	  sleep(200)
	  ;ToolTip("topsafe",1920,0)
   ElseIf isMiddleSafe() Then
	  mClick(307,673)
	  sleep(200)
	  ;ToolTip("Middle",1920,0)
   ElseIf isBottomSafe() Then
	  mClick(307,845)
	  sleep(200)
	  ;ToolTip("Bottom",1920,0)
   ElseIf isLastSafe() Then
	  mClick(307,994)
	  sleep(200)
	  ;ToolTip("Lastsafe",1920,0)
   Else
   #ce
	  mClick(307,523)
	  sleep(1000)
	  ;ToolTip("none",1920,0)
   ;EndIf
EndFunc

;QuickGame Functions
Func quickGameMain()
   if isQuickGameOpponent() Then
	  launchQuickGame()
   ElseIf isCardsMax() Then
	  sleep(200)
	  clickOK()
	  $cardsFull = True
   Else
	  While Not isQuickGameOpponent()
		 If isQuickGamePlay() Then
			playQuickGame()
		 ElseIf isRewardsChoose() Then
			getReward()
		 ElseIf isRewardsProceed() Then
			getProceed()
		 Else
			shortSpeedClick()
		 EndIf
	  WEnd
   EndIf
EndFunc

Func playQuickGame()
   ;Local $playerStats[5][5] = [[81,320,1642,1567,2664],[68,303,1620,1571,2479],[62,258,1489,1638,2428],[63,278,1528,1475,2342],[63,278,1528,1532,2481]] ;3epic
   Local $playerStats[5][5] = [[1729,1642,1426,1567,2664],[1515,1620,1255,1571,2479],[1450,1589,1224,1638,2428],[1563,1528,1259,1475,2342],[1554,1534,1261,1532,2481]] ;3epic

   Local $breakCount = 0
   $sandBagOne = True
   $sandBagTwo = False
   $sandBagPlayerOne = 2
   $sandBagPlayerTwo = 0
   $playerPos = -1
   While isQuickGamePlay() and Not isQuickGameQuarterShowing() and $breakCount < 10
	  shortSpeedClick()
   WEnd
   $breakCount = 0
   While isQuickGamePlay() and isQuickGameQuarterShowing() and $breakCount < 5 ;while isquickgameplay()
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
	  ElseIf $breakCount = 2 and $SandBagTwo and isScoreTied() Then
		 $playerPos = $sandBagPlayerTwo
		 $playerStats = statChange($playerStats,$playerPos)
		 $sandBagTwo = False
	  Else
		 $playerPos = statCheck($playerStats)
		 $playerStats = statChange($playerStats,$playerPos)
	  EndIf
	  For $i = 1 to 8
		 playerClick($playerPos)
	  Next
	  $clickBreak = 0
	  While isQuickGamePlay() and Not isQuickGameQuarterShowing() and $clickBreak < 75
		 playerClick($playerPos)
		 $clickBreak = $clickBreak + 1
	  WEnd
	  $breakCount = $breakCount + 1
   WEnd
EndFunc