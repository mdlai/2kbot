;Game State
Func isSeason()
   Return compareCheckSum(2720342180,363,599,505,640)
EndFunc

Func isManageSeason()
   Return compareCheckSum(2129712644,365,820,448,847)
EndFunc

Func isSeasonCardOpen()
   Return compareCheckSum(2683098972,163,908,282,941)
EndFunc

;Season Functions
Func energyRefill() ;uses mDrag()
   $energyX = 93
   $energyY = 871
   mDrag($energyX,$energyY,98,296)
   energyRefillLag()
   mDrag($energyX,$energyY,182,336)
   energyRefillLag()
   mDrag($energyX,$energyY,288,301)
   energyRefillLag()
   mDrag($energyX,$energyY,374,324)
   energyRefillLag()
   mDrag($energyX,$energyY,473,324)
   energyRefillLag()
   mDrag($energyX,$energyY,570,331)
   energyRefillLag()
   mDrag($energyX,$energyY,258,490)
   energyRefillLag()
   mDrag($energyX,$energyY,350,498)
   energyRefillLag()
   mDrag($energyX,$energyY,465,489)
   energyRefillLag()
   mDrag($energyX,$energyY,565,501)
   energyRefillLag()
   MouseMove(3840,2160)
EndFunc

Func energyRefillLag()
   $breakcount = 0
   While Not isManageSeason() and $breakcount < 10
	  sleep(1000)
   WEnd
EndFunc

