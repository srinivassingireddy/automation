'******************************************************************************
'* Provides data from disks from a list of servers (servers.txt)              *
'* so if you can't connect to a server it will repeat the data from last.     *
'* Also I include the date on the name of the report file and on it header.   *
'* It can be usefull if you need to check it every day                        *
'******************************************************************************

On Error Resume Next
Const ForAppending = 8
Const HARD_DISK = 3
Const ForReading = 1

Const strMailRelayHost = "smtp.stanfordmed.org"
' SMTP Relay hostname

Const strMailFromDomain = "Windows_File_Servers@stanfordhealthcare.org"
' The script sends emails about it's actions, this is the FROM Address

'strMailto = "TJafarullah@stanfordhealthcare.org"
strMailto = "dl-hcl-wintel@stanfordhealthcare.org"
' The list of recipients we send the email message to' 
'Const strMailtoScriptDown = "TJafarullah@stanfordhealthcare.org"
'Const strMailtoScriptDown = "skamalakannan@stanfordhealthcare.org;dl-hcl-wintel@stanfordhealthcare.org"
'  strMailtoScriptDown 

strCompName = "Mail"

strPath = Wscript.ScriptFullName
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.GetFile(strPath)
strFolder = objFSO.GetParentFolderName(objFile) 

StrHtml = strFolder & "\" & "File_Server_Disk_Space.Html"


if objfso.FileExists(StrHtml) then
	objfso.DeleteFile StrHtml
end if

'Var declaration
dtmDay = Day(Date)
dtmMonth = Month(Date)
dtmYear = Year(Date)
dtmDate = CDate(dtmYear & "-" & dtmMonth & "-" & dtmDay)

Set objFSO = CreateObject("Scripting.FileSystemObject")

'Open the server list
Set SrvList = objFSO.OpenTextFile("Servers.txt", ForReading)

'Create a result file
Set ReportFile = objFSO.OpenTextFile (StrHtml, ForAppending, True)

i = 0


'Inicializar HTML
ReportFile.writeline("<html>")
ReportFile.writeline("<head>")
ReportFile.writeline("<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>")
ReportFile.writeline("<title>" & "Server Space Disk Report " & dtmDate & "</title>")
ReportFile.writeline("<style type='text/css'>")
ReportFile.writeline("<!--")
ReportFile.writeline("td {")
ReportFile.writeline("font-family: Tahoma;")
ReportFile.writeline("font-size: 11px;")
ReportFile.writeline("border-top: 1px solid #999999;")
ReportFile.writeline("border-right: 1px solid #999999;")
ReportFile.writeline("border-bottom: 1px solid #999999;")
ReportFile.writeline("border-left: 1px solid #999999;")
ReportFile.writeline("padding-top: 0px;")
ReportFile.writeline("padding-right: 0px;")
ReportFile.writeline("padding-bottom: 0px;")
ReportFile.writeline("padding-left: 0px;")
ReportFile.writeline("}")
ReportFile.writeline("body {")
ReportFile.writeline("margin-left: 5px;")
ReportFile.writeline("margin-top: 5px;")
ReportFile.writeline("margin-right: 0px;")
ReportFile.writeline("margin-bottom: 10px;")
ReportFile.writeline("")
ReportFile.writeline("table {")
ReportFile.writeline("border: thin solid #000000;")
ReportFile.writeline("}")
ReportFile.writeline("-->")
ReportFile.writeline("</style>")
ReportFile.writeline("</head>")
ReportFile.writeline("<body>")

ReportFile.writeline("<table width='50%'>")
ReportFile.writeline("<tr bgcolor='#CCCCCC'>")
ReportFile.writeline("<td colspan='7' height='25' align='center'>")
ReportFile.writeline("<font face='tahoma' color='#003399' size='2'><strong>File Server Clusters Disk Report " & dtmdate & "</strong></font>")
ReportFile.writeline("</td>")
ReportFile.writeline("</tr>")
ReportFile.writeline("</table>")


'Server name declaration
Do Until SrvList.AtEndOfStream
	StrComputer = SrvList.Readline

	Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
	Set colDisks = objWMIService.ExecQuery("Select * from Win32_LogicalDisk Where DriveType = " & HARD_DISK & "")

	If Err.Number <> 0 Then 
		ReportFile.writeline("<table width='50%'><tbody>")
		ReportFile.writeline("<tr bgcolor='#FF0000'>")
		ReportFile.writeline("<td width='50%' align='center' colSpan=6><font face='tahoma' color='#003399' size='2'><strong>Error - " & StrComputer & " - Error</strong></font></td>")
		ReportFile.writeline("</tr>")
		Err.Clear
	Else

	ReportFile.writeline("<table width='50%'><tbody>")
	ReportFile.writeline("<tr bgcolor='#CCCCCC'>")
	ReportFile.writeline("<td width='50%' align='center' colSpan=6><font face='tahoma' color='#003399' size='2'><strong>" & StrComputer & "</strong></font></td>")
	ReportFile.writeline("</tr>")

	ReportFile.writeline("<tr bgcolor=#CCCCCC>")
		ReportFile.writeline("<td width='20%' align='center'>Drive / Mount</td>")
		ReportFile.writeline("<td width='20%' align='center'>Volume_Label</td>")
		ReportFile.writeline("<td width='20%' align='center'>Total Capacity (in GB)</td>")
		ReportFile.writeline("<td width='20%' align='center'>Used Capacity (in GB)</td>")
		ReportFile.writeline("<td width='20%' align='center'>Free Space (in GB)</td>")
		ReportFile.writeline("<td width='20%' align='center'>Freespace %</td>")
	ReportFile.writeline("</tr>") 

		'Data recolection
		For Each objDisk in colDisks

			'Var init
			TotSpace=0
			FrSpace=0
			FrPercent=0
			UsSpace=0
			Drv="Error"
			VolName="Error"


			'Var charge
			
			TotSpace=Round(((objDisk.Size)/1073741824),2)
			FrSpace=Round(objDisk.FreeSpace/1073741824,2)
			FrPercent=Round((FrSpace / TotSpace)*100,0)
			UsSpace=Round((TotSpace - FrSpace),2)
			Drv=objDisk.DeviceID
			VolName=objDisk.VolumeName

			'Lnt=Len(VolName)

			'If  Len(VolName) =  3 then
				If FrPercent > 19 Then
					ReportFile.WriteLine "<tr><td align=center>" & Drv & "</td><td align=center>" & Volname & "</td><td align=center>" & TotSpace & "</td><td align=center>" & UsSpace & "</td><td align=center>" & FrSpace & "</td><td BGCOLOR='#00FF00' align=center>" & FrPercent & "%" &"</td></tr>"
				ElseIf FrPercent < 10 Then
					ReportFile.WriteLine "<tr><td align=center>" & Drv & "</td><td align=center>" & Volname & "</td><td align=center>" & TotSpace & "</td><td align=center>" & UsSpace & "</td><td align=center>" & FrSpace & "</td><td bgcolor='#FF0000' align=center>" & FrPercent & "%" &"</td></tr>"
				Else
					ReportFile.WriteLine "<tr><td align=center>" & Drv & "</td><td align=center>" & Volname & "</td><td align=center>" & TotSpace & "</td><td align=center>" & UsSpace & "</td><td align=center>" & FrSpace & "</td><td bgcolor='#FBB917' align=center>" & FrPercent & "%" &"</td></tr>"
				End If
			'Else
			'End If
		Next

	End If

	ReportFile.writeline("<tr>")
	ReportFile.writeline("<td width='50%' colSpan=6>&nbsp;</td>")
	ReportFile.writeline("</tr>")

	ReportFile.writeline("</tbody></table>")
Loop
ReportFile.WriteLine "</body></html>"


strSubject = "Windows File Server Disk Status - " & dtmDate



'*** Send SMTP eMail
'Function SendMail(strSubject,strBody)
Dim objEmail
Set objEmail = CreateObject("CDO.Message")
ObjEmail.CreateMHTMLBody "file://" &strHTML
'ObjEmail.HTMLBody = strHTML
objEmail.From = StrCompName & strMailFromDomain
objEmail.To = strMailTo
objEmail.Subject = strSubject
objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = _
        strMailRelayHost 
objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
objEmail.Configuration.Fields.Update
'objEmail.AddAttachment StrHtml
objEmail.Send
'End Function

