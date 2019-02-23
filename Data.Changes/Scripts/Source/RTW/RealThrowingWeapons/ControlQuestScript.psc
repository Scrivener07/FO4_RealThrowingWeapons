Scriptname RealThrowingWeapons:ControlQuestScript extends Quest
{Slows time when Grenade key press in and aiming Thrown weapon.}
import RealThrowingWeapons:Log


bool bControlDown = false
bool bEffectActive = false

string MeleeControl = "Melee" const
float TimerDelay = 0.2 const


; Events
;---------------------------------------------

Event OnControlDown(string control)
	; No need to differentiate keys as we only registered for 1.
	; Because of the default problem that Melee key and Greande key are one in the same, we will try to work around it.

	; Start a very small timer to release the thread. We will use a Bool to act as a simple switch.

	; When OnControlDown is received, set Bool to true
	; When OnControlUp is received, set false.

	; If Timer would find the Bool to be true, apply effect.
	; Set another Bool true for effect active. So it can be removed when control goes up.
	; Testing must be done as to how feasible all this will be for the end user experience.

	bControlDown = true
	StartTimer(TimerDelay)
EndEvent


Event OnTimer(int aiTimerID)
	; Only one timer registered, run without checking ID
	If (bControlDown) ; Still down, play effect
		RTW_SlowTimeSpell.Cast(PlayerRef, PlayerRef) ; Should be constant effect so it doesn't dispel while key is down.
		Crosshair.Open()
		bEffectActive = true
	EndIf
EndEvent


Event OnControlUp(string control, float time)
	If (bEffectActive)
		PlayerRef.DispelSpell(RTW_SlowTimeSpell)
		Crosshair.Close()
	EndIf
	bControlDown = false
EndEvent


Event Actor.OnSit(Actor akSender, ObjectReference akFurniture)
	;If (akFurniture.HasKeyword(FurnitureTypePowerArmor))
		RegisterKeys()
	;EndIf
EndEvent


Event Actor.OnGetUp(Actor akSender, ObjectReference akFurniture)
	;If (akFurniture.HasKeyword(FurnitureTypePowerArmor))
		UnregisterKeys()
	;EndIf
EndEvent


; Functions
;---------------------------------------------

Function RegisterKeys()
	{Registers for key events when weapon is equipped.}
	; By default there is no Grenade key.
	; Can modify F4SE control map/use mod if desired. Here we will try to workaround it for now.

	RegisterForControl(MeleeControl)
	;Debug.MessageBox("Registered for controls")
EndFunction


Function UnregisterKeys()
	{Unregisters for key events when weapon is unequipped.}
	; Script should be unregistered when it is dispelled by the Equip script.
	; However due to OnUnequipped being unreliable, it may never dispel. This must be tested thoroughly.
	; If it works out to be problematic, we will look at some different methods.

	UnregisterForControl(MeleeControl)
	;Debug.MessageBox("Unregistered for controls")
EndFunction


; Properties
;---------------------------------------------
; Both Spells needs to be set to Constant Effect, Delivery = Self.
; This spell should be SCRIPT archetype, with real Slow Time spell being SLOW TIME type.

Group Properties
	Actor Property PlayerRef Auto Const Mandatory ;Keep a permanent link, faster.
	{The player actor reference.}

	Spell Property RTW_SlowTimeSpell Auto Const Mandatory
	{Set the real Slow Time spell here}

	RealThrowingWeapons:Crosshair Property Crosshair Auto Const Mandatory
EndGroup
