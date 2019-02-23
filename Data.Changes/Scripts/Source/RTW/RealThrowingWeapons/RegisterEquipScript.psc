Scriptname RealThrowingWeapons:RegisterEquipScript extends ObjectReference
{Slows time when Grenade key held in. Requires F4SE.}
; Written by SMB92 for MunkySpunk


; Events
;---------------------------------------------

Event OnEquipped(Actor akActor)
	If (akActor == PlayerRef) ; Prevent other actors running this.
		ControlQuest.RegisterKeys()
	EndIf
EndEvent


; Native functions are not reliable in this event, this needs to be tested a lot. Hence the "Pre" spell that does the heavier work.
Event OnUnequipped(Actor akActor)
	If (akActor == PlayerRef) ; Prevent other actors running this.
		ControlQuest.UnregisterKeys()
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Properties
	RealThrowingWeapons:ControlQuestScript Property ControlQuest Auto Const Mandatory
	{The real thowing weapons control quest.}

	Actor Property PlayerRef Auto Const Mandatory
	{The player actor reference.}
EndGroup
