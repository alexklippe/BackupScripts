
Set oFileSys = WScript.CreateObject("Scripting.FileSystemObject")
sRoot = "E:\backup\sasha3"			'Path root to look for files
today = Date
nMaxFileAge = 14				'Files older than this (in days) will be deleted
HostName="sasha3"

DeleteFiles(sRoot)

SendEmail()

Function DeleteFiles(ByVal sFolder)

	Set oFolder = oFileSys.GetFolder(sFolder)
	Set aFiles = oFolder.Files
	Set aSubFolders = oFolder.SubFolders

	For Each file in aFiles
		dFileCreated = FormatDateTime(file.DateCreated, "2")
		If DateDiff("d", dFileCreated, today) > nMaxFileAge Then
			file.Delete(True)
		End If
	Next

	For Each folder in aSubFolders
		DeleteFiles(folder.Path)
	Next

End Function

Function SendEmail()
Set objMessage = CreateObject("CDO.Message") 
objMessage.Subject = HostName+" Backup Complete" 
objMessage.From = "admin@***" 
objMessage.To = "alex@***"
objMessage.TextBody = HostName+" Backup Complete." 
'==This section provides the configuration information for the remote SMTP server.
'==Normally you will only change the server name or IP. 
objMessage.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 
'Name or IP of Remote SMTP Server 
objMessage.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "smtp.gmail.com"
'Server port (typically 25) 
objMessage.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465 
objMessage.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1 
objMessage.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = true 
objMessage.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusername") = "admin@***" 
objMessage.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "***" 
objMessage.Configuration.Fields.Update 
'==End remote SMTP server configuration section== 
objMessage.Send


End Function