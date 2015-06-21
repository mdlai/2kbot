;Game State
Func isSelectACardToTrain()
   return compareCheckSum(1045471851,395,36,551,77)
EndFunc

Func isTrainActive()
   return compareCheckSum(2313271173,259,958,397,998)
EndFunc

Func isTrainCard()
   return compareCheckSum(3535700462,364,31,533,120)
EndFunc

Func isTrainingCards()
   if compareCheckSum(2113989026,343,32,499,78) and Not isTrainCard() Then
	  Return True
   Else
	  Return False
   EndIf
EndFunc

Func isFilterCommon()
   return compareCheckSum(3732883252,456,128,507,148)
EndFunc

Func isFilterUncommon()
   return compareCheckSum(553578395,472,129,523,147)
EndFunc

Func isFilterRare()
   return compareCheckSum(1005541474,447,122,492,148)
EndFunc

Func isFilterSupport()
   Return compareCheckSum(2115932446,401,111,515,144)
EndFunc

Func isFilterNone()
   return compareCheckSum(3312684987,424,113,495,148)
EndFunc

Func isAboutToLoseARare()
   If compareCheckSum(4171138012,383,440,583,537) or  compareCheckSum(467824453,165,434,285,482) Then
	  Return True
   Else
	  Return False
   EndIf
EndFunc

Func isTrainCombine()
   return compareCheckSum(2085651315,142,393,493,542)
EndFunc

;Control Functions
Func trainCombine()
   if isTrainCombine() Then
	  clickYes()
   EndIf
EndFunc

Func clickTopCard()
   ;mClick(625,244) ;Top Card
   mClick(625,420) ;Second Card
   sleep(1200)
EndFunc

Func clickYes()
   mClick(489,727)
EndFunc

Func clickNo()
   mClick(489,824)
EndFunc

Func changeFilter()
   mClick(535,129)
   sleep(200)
   if isFilterCommon() or isFilterUncommon() or isFilterRare() or isFilterNone() Then
	  sleep(2000)
   EndIf
EndFunc

Func clickTrain()
   mClick(330,980)
EndFunc

Func trainSpeedClick()
   For $i = 1 to 3
	  mClick(614,123)
	  sleep(300)
   Next
EndFunc

Func clickFourCards()
   mClick(46,980)
   mClick(46,850)
   mClick(46,700)
   mClick(46,525)
   sleep(450)
EndFunc

;Training Functions
Func trainTopCard()
   $isCommonCardsRemain = 1
   $isUncommonCardsRemain = 1
   $isRareCardsRemain = 1
   $trainBreak = 0
   While $isCommonCardsRemain = 1 or $isUncommonCardsRemain = 1 or $isRareCardsRemain = 1
	  If isSelectACardToTrain() and isFilterNone() Then ;Choose Card Correct Filter
		 clickTopCard()
		 $trainBreak = $trainBreak + 1
		 if $trainBreak > 10 Then
			ExitLoop
		 EndIf
	  ElseIf isSelectACardToTrain() and Not isFilterNone() Then ;Choose Card Incorrect Filter
		 changeFilter()
	  ElseIf isTrainCard() Then ;Card Chosen
		 $trainBreak = 0
		 If isFilterCommon() and $isCommonCardsRemain = 1 Then ;Filter Correct, Cards Remain
			clickFourCards()
			If isTrainActive() Then
			   clickTrain()
			   trainCombine()
			   trainSpeedClick()
			Else
			   $isCommonCardsRemain = 0
			EndIf
		 ElseIf isFilterUncommon() and $isUncommonCardsRemain = 1 Then ;Uncommons
			clickFourCards()
			If isTrainActive() Then
			   clickTrain()
			   trainCombine()
			   trainSpeedClick()
			Else
			   $isUncommonCardsRemain = 0
			EndIf
		 ElseIf isFilterRare() and $isRareCardsRemain = 1 Then ;Rares
			clickFourCards()
			If isTrainActive() Then
			   clickTrain()
			   sleep(600)
			   If isAboutToLoseARare() Then
				  clickYes()
			   EndIf
			   trainCombine()
			   trainSpeedClick()
			Else
			   $isRareCardsRemain = 0
			EndIf
		 ElseIf isAboutToLoseARare() Then
			clickNo()
		 ElseIf isTrainCombine() Then
			trainCombine()
			trainSpeedClick()
		 Else
			changeFilter()
		 EndIf
	  ElseIf isTrainingCards() Then
		 trainSpeedClick()
	  ElseIf isAboutToLoseARare() Then
		 clickNo()
	  ElseIf isTrainCombine() Then
		 trainCombine()
		 trainSpeedClick()
	  EndIf
   WEnd
   $cardsFull = False
   sleep(1000)
EndFunc