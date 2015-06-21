Func isMyCards()
   if compareCheckSum(1590156376,440,192,606,210) and compareCheckSum(969970017,210,35,639,85) Then
	  return True
   Else
	  Return False
   EndIf
EndFunc

Func isDeleteConfirm()
   return compareCheckSum(2407763921,178,387,464,527)
EndFunc

Func isDeleteAvailable()
   return compareCheckSum(3597670512,496,970,630,1001)
EndFunc

Func clickDelete()
   mClick(564,988)
EndFunc

Func getDeleteCard()
   $clickCountBreak = 0
   While Not isDeleteConfirm() and $clickCountBreak < 5
	  clickDelete()
	  sleep(200)
	  $clickCountBreak = $clickCountBreak + 1
   WEnd
EndFunc

Func cardDelete()
   $isCommonCardsRemain = True
   $isUncommonCardsRemain = True
   $isSupportCardsRemain = True
   $isRareCardsRemain = True
   $rareDeletes = 0
   While $isCommonCardsRemain or $isUncommonCardsRemain or $isRareCardsRemain or $isSupportCardsRemain
	  if isFilterCommon() And $isCommonCardsRemain Then
		 getDeleteCard()
		 if isDeleteConfirm() Then
			clickYes()
			sleep(200)
			$deleteSleepBreak = 0
			While Not isDeleteAvailable() and $deleteSleepBreak < 15
			   sleep(100)
			   $deleteSleepBreak = $deleteSleepBreak + 1
			WEnd
		 Else
			$isCommonCardsRemain = False
		 EndIf
	  ElseIf isFilterUncommon() And $isUncommonCardsRemain Then
		 getDeleteCard()
		 if isDeleteConfirm() Then
			clickYes()
			sleep(200)
			$deleteSleepBreak = 0
			While Not isDeleteAvailable() and $deleteSleepBreak < 15
			   sleep(100)
			   $deleteSleepBreak = $deleteSleepBreak + 1
			WEnd
		 Else
			$isUncommonCardsRemain = False
		 EndIf
	  ElseIf isFilterSupport() And $isSupportCardsRemain Then
		 getDeleteCard()
		 if isDeleteConfirm() Then
			clickYes()
			sleep(200)
			$deleteSleepBreak = 0
			While Not isDeleteAvailable() and $deleteSleepBreak < 15
			   sleep(100)
			   $deleteSleepBreak = $deleteSleepBreak + 1
			WEnd
		 Else
			$isSupportCardsRemain = False
		 EndIf
	  ElseIf isFilterRare() And $isRareCardsRemain and $rareDeletes < 3 Then
		 getDeleteCard()
		 if isDeleteConfirm() Then
			clickYes()
			$rareDeletes = $rareDeletes + 1
			sleep(200)
			$deleteSleepBreak = 0
			While Not isDeleteAvailable() and $deleteSleepBreak < 15
			   sleep(100)
			   $deleteSleepBreak = $deleteSleepBreak + 1
			WEnd
		 Else
			$isRareCardsRemain = False
		 EndIf
	  ElseIf $isRareCardsRemain and $rareDeletes > 1 Then
		 $isRareCardsRemain = False
	  ElseIf isDeleteConfirm() Then
		 clickNo()
	  Else
		 changeFilter()
		 if isFilterCommon() or isFilterUncommon() or isFilterSupport() or isFilterRare() or isFilterNone() Then
			sleep(2000)
		 EndIf
	  EndIf
   WEnd
   $cardsFull = False
   sleep(500)
   If isDeleteConfirm() Then
		 clickNo()
   EndIf
EndFunc





#cs
Func cardDelete()
   $isCommonCardsRemain = True
   $isUncommonCardsRemain = True
   While $isCommonCardsRemain or $isUncommonCardsRemain
	  if isFilterCommon() And $isCommonCardsRemain and isDeleteAvailable() Then
		 deleteCard()
	  ElseIf isFilterCommon() and $isCommonCardsRemain and Not isDeleteAvailable() Then
		 $isCommonCardsRemain = False
		 changeFilter()
	  ElseIf isFilterUncommon() And $isUncommonCardsRemain and isDeleteAvailable() Then
		 deleteCard()
	  ElseIf isFilterUncommon() and $isUncommonCardsRemain and Not isDeleteAvailable() Then
		 $isCommonCardsRemain = False
		 changeFilter()
	  ElseIf isDeleteConfirm() Then
		 clickNo()
	  Else
		 changeFilter()
		 sleep(1000)
	  EndIf
   WEnd
   $cardsFull = False
   sleep(500)
EndFunc
#ce