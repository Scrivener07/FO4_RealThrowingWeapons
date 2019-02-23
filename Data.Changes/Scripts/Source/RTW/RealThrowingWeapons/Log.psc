ScriptName RealThrowingWeapons:Log Const Native Hidden DebugOnly
{Provides debug logging for ODST script objects.}

; Logging
;---------------------------------------------

bool Function Write(string prefix, string text) Global DebugOnly
	{Writes text as lines in a log file.}
	string filename = "RealThrowingWeapons" const
	text = prefix + " " + text
	If(Debug.TraceUser(filename, text))
		return true
	Else
		Debug.OpenUserLog(filename)
		return Debug.TraceUser(filename, text)
	EndIf
EndFunction


bool Function WriteNotification(string prefix, string text) Global DebugOnly
	{Writes notifications as lines in a log file.}
	Debug.Notification(text)
	return Write(prefix, text)
EndFunction


bool Function WriteMessage(string prefix, string title, string text = "") Global DebugOnly
	{Writes messages as lines in a log file.}
	string value
	If !(StringIsNoneOrEmpty(text))
		value = title+"\n"+text
	EndIf
	Debug.MessageBox(value)
	return Write(prefix, title+" "+text)
EndFunction


; Debug
;---------------------------------------------

bool Function WriteLine(var script, string member, string text = "") Global DebugOnly
	{Writes script info as lines in a log file.}
	If (StringIsNoneOrEmpty(text))
		return Write(script, member)
	Else
		return Write(script+"["+member+"]", text)
	EndIf
EndFunction


bool Function WriteUnexpected(var script, string member, string text = "") Global DebugOnly
	{The script had an unexpected operation.}
	return Write(script+"["+member+"]", "The member '"+member+"' had an unexpected operation. "+text)
EndFunction


bool Function WriteUnexpectedValue(var script, string member, string variable, string text = "") Global DebugOnly
	{The script had and unexpected value.}
	return Write(script+"["+member+"."+variable+"]", "The member '"+member+"' with variable '"+variable+"' had an unexpected operation. "+text)
EndFunction


bool Function WriteNotImplemented(var script, string member, string text = "") Global DebugOnly
	{The exception that is thrown when a requested method or operation is not implemented.}
	; The exception is thrown when a particular method, get accessors, or set accessors is present as a member of a type but is not implemented.
	return Write(script, member+": The member '"+member+"' was not implemented. "+text)
EndFunction


; String
;---------------------------------------------

bool Function StringIsNoneOrEmpty(string value) Global
	{Indicates whether the specified string is none or an empty string.}
	return !(value) || value == ""
EndFunction
