Scriptname RealThrowingWeapons:Crosshair extends RealThrowingWeapons:Type
import RealThrowingWeapons:Log

; Events
;---------------------------------------------

Event OnQuestInit()
	RegisterForGameReload(self)
	OnGameReload()
EndEvent


Event OnGameReload()
	If (!IsRegistered)
		UI:MenuData data = new UI:MenuData
		data.MenuFlags = FlagDoNotPreventGameSave
		data.ExtendedFlags = FlagInheritColors
		If (UI.RegisterCustomMenu(Name, Path, Root, data))
			WriteLine(ToString(), "Actor.OnPlayerLoadGame", "Registered as a custom menu.")
		Else
			WriteUnexpected(ToString(), "Actor.OnPlayerLoadGame", "Failed to register as a custom menu.")
		EndIf
	EndIf
EndEvent


; Methods
;---------------------------------------------

bool Function Open()
	If (IsOpen)
		WriteLine(ToString(), "Open", "This menu is already open.")
		return true
	Else
		If (IsRegistered)
			return UI.OpenMenu(Name)
		Else
			WriteUnexpectedValue(ToString(), "Open", "IsRegistered", "This menu is not registered.")
			return false
		EndIf
	EndIf
EndFunction


bool Function Close()
	If (!IsOpen)
		WriteLine(ToString(), "Close", "This menu is already closed.")
		return true
	Else
		If (IsRegistered)
			return UI.CloseMenu(Name)
		Else
			WriteUnexpectedValue(ToString(), "Close", "IsRegistered", "This menu is not registered.")
			return false
		EndIf
	EndIf
EndFunction


; Functions
;---------------------------------------------

string Function ToString()
	{The string representation of this type.}
	return parent.ToString()+"[Name:"+Name+", Path:"+Path+", Root:"+Root+"]"
EndFunction


; Properties
;---------------------------------------------

Group Properties
	string Property Name Hidden
		string Function Get()
			{The registered name of this menu.}
			return "RealThrowingWeapons_Crosshair"
		EndFunction
	EndProperty

	string Property Path Hidden
		string Function Get()
			{The swf file path of this menu without the file extension. The root directory is "Data\Interface".}
			return "RealThrowingWeapons\\Crosshair"
		EndFunction
	EndProperty

	string Property Root Hidden
		string Function Get()
			{The root instance path of this menu's display object.}
			return "root1"
		EndFunction
	EndProperty

	bool Property IsOpen Hidden
		bool Function Get()
			{Returns true if this menu is open.}
			return UI.IsMenuOpen(Name)
		EndFunction
	EndProperty

	bool Property IsRegistered Hidden
		bool Function Get()
			{Returns true if this menu is registered.}
			return UI.IsMenuRegistered(Name)
		EndFunction
	EndProperty
EndGroup

Group MenuFlags
	int Property FlagNone = 0x0 AutoReadOnly
	int Property FlagDoNotPreventGameSave = 0x800 AutoReadOnly
EndGroup

Group ExtendedFlags
	int Property FlagInheritColors = 1 AutoReadOnly
EndGroup
