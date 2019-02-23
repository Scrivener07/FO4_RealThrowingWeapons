Scriptname RealThrowingWeapons:ThrownWeaponRetrieval extends ActiveMagicEffect
import RealThrowingWeapons:Log

; Events
;---------------------------------------------

Event OnEffectStart(Actor target, Actor thrower)
	If(target)
		target.AddItem(Thrown, 1, true)
		WriteLine(self, "OnEffectStart", "Added "+Thrown+" to "+target+"'s inventory.")
	Else
		WriteUnexpectedValue(self, "OnEffectStart", "target", "The value cannot be none.")
	EndIf
EndEvent

; Properties
;---------------------------------------------

Group Properties
	Weapon Property Thrown Auto Const Mandatory
EndGroup
