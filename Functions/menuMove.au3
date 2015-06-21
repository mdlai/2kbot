Func isMainMenu()
   return compareCheckSum(2213476971,265,34,455,78)
EndFunc

;Menu Functions
Func menuBack()
   mClick(39,33)
   sleep(7000)
EndFunc

Func menuEscapeToMain()
   While Not isMainMenu()
	  menuBack()
   WEnd
EndFunc

Func menuLogin()
   While Not isMainMenu()
	  mclick(10,898)
	  sleep(20000)
	  if isMainMenu() Then
		 menuScrollToBottom()
	  ElseIf isNetworkError() Then
		 menuNetworkOK()
	  Else
		 menuBack()
	  EndIf
   WEnd
EndFunc

Func menuScrollToBottom()
   mDrag(10,898,10,144)
   mDrag(10,898,10,144)
EndFunc
;Fix
Func menuNetworkOK()
   mClick(178,738)
EndFunc

;RivalsClash
Func menuRivalsClash()
   mClick(330,77)
   sleep(7000)
EndFunc


Func menuGoToRivalsClash() ;doublecheck
   While Not isRivalsClashMenu() and Not isRewardsChoose() and Not isRewardsProceed() and Not isRivalsClashPlay() and Not isRivalsClashOpponent()
	  If isMainMenu() Then
		 menuRivalsClash()
	  Else
		 menuEscapeToMain()
	  EndIf
   WEnd
EndFunc


;QuickGame
Func menuQuickGame()
   mClick(309,280)
   sleep(7000)
EndFunc

Func menuGoToQuickGame()
   While Not isQuickGameOpponent() and Not isRewardsChoose() and Not isRewardsProceed() and Not isQuickGamePlay()
	  if isMainMenu() Then
		 menuQuickGame()
	  Else
		 menuEscapeToMain()
	  EndIf
   WEnd
EndFunc


;Manage Season
Func menuSeason()
   mClick(309,559)
   sleep(7000)
EndFunc

Func menuManageSeason()
   mClick(516,619)
   sleep(7000)
EndFunc

Func menuGoToManageSeason()
   While Not isManageSeason()
	  if isSeason() Then
		 menuManageSeason()
	  ElseIf isMainMenu() Then
		 menuSeason()
	  Else
		 menuEscapeToMain()
	  EndIf
   WEnd
EndFunc


;Train
Func menuTrain()
   mClick(309,817)
   sleep(7000)
EndFunc

Func menuGoToTrain()
   While Not isSelectACardToTrain()
	  if isMainMenu() Then
		 menuTrain()
	  Else
		 menuEscapeToMain()
	  EndIf
   WEnd
EndFunc

;MyCards must be updated
Func menuMyCards()
   mClick(309,637)
   sleep(7000)
EndFunc

Func menuGoToMyCards()
   While Not isMyCards()
	  if isMainMenu() Then
		 menuMyCards()
	  Else
		 menuEscapeToMain()
	  EndIf
   WEnd
EndFunc