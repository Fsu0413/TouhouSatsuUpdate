Option Explicit 

Dim updatePackage
updatePackage = "UpdatePack.7z"

If WScript.Arguments.length <> 1 Then
    WScript.Echo "Should provide a pid to wait"
    WScript.Quit 1
End If

Dim pid
pid = CLng(WScript.Arguments(0))

If pid = 0 Then
    WScript.echo "pid is not available"
    WScript.Quit 1
End If

Dim fso
Set fso = WScript.CreateObject("Scripting.Filesystemobject")

If Not fso.FileExists(updatePackage) Then
    WScript.Echo "updatepack does not exist"
    WScript.Quit 1
End If

Dim exist
Do
    exist = False
    Dim strComputer
    strComputer = "."
    Dim objWMIService
    Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
    Dim colItems
    Set colItems = objWMIService.ExecQuery("Select * from Win32_Process", , 48)
    
    Dim objItem
    For Each objItem In colItems
        If objItem.ProcessId = pid Then
            exist = True
            WScript.Sleep 1000
            Exit For
        End If
    Next
    
    Set colItems = Nothing
    Set objWMIService = Nothing
Loop While exist

Dim WshShell
Set WshShell = WScript.CreateObject("Wscript.Shell")

Dim errno 
errno = WshShell.run("cmd /c 7zr.exe x -y " & updatePackage, , True)


If errno <> 0 Then
    WScript.Echo "Update pack extract failed, please use 7-Zip to extract the files from """ & updatePackage & """."
    WScript.Quit 1
End If

' run QSanguosha
Dim WshApp 
Set WshApp = WScript.CreateObject("Shell.Application")

WshApp.ShellExecute "QSanguosha.exe"

' delete update files
fso.DeleteFile updatePackage, True
fso.DeleteFile WScript.ScriptFullName, True

WScript.Quit 0
