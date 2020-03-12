
  
# FTP Server Variables
$FTPHost = 'ftp://***/Backup/Dimir/'
$FTPUser = 'dimirservi'
$FTPPass = '***'
  
#Directory where to find pictures to upload
$UploadFolder = "E:\backup"
   
$webclient = New-Object System.Net.WebClient
$webclient.Credentials = New-Object System.Net.NetworkCredential($FTPUser,$FTPPass) 
  
$SrcEntries = Get-ChildItem $UploadFolder -Recurse
$Srcfolders = $SrcEntries | Where-Object{$_.PSIsContainer}
$SrcFiles = $SrcEntries | Where-Object{!$_.PSIsContainer}
  
# Create FTP Directory/SubDirectory If Needed - Start
foreach($folder in $Srcfolders)
{   
    $SrcFolderPath = $UploadFolder  -replace "\\","\\" -replace "\:","\:"  
    $DesFolder = $folder.Fullname -replace $SrcFolderPath,$FTPHost
    $DesFolder = $DesFolder -replace "\\", "/"
    # Write-Output $DesFolder
  
    try
        {
            $makeDirectory = [System.Net.WebRequest]::Create($DesFolder);
            $makeDirectory.Credentials = New-Object System.Net.NetworkCredential($FTPUser,$FTPPass);
            $makeDirectory.Method = [System.Net.WebRequestMethods+FTP]::MakeDirectory;
            $makeDirectory.GetResponse();
            #folder created successfully
        }
    catch [Net.WebException]
        {
            try {
                #if there was an error returned, check if folder already existed on server
                $checkDirectory = [System.Net.WebRequest]::Create($DesFolder);
                $checkDirectory.Credentials = New-Object System.Net.NetworkCredential($FTPUser,$FTPPass);
                $checkDirectory.Method = [System.Net.WebRequestMethods+FTP]::PrintWorkingDirectory;
                $response = $checkDirectory.GetResponse();
                #folder already exists!
            }
            catch [Net.WebException] {
                #if the folder didn't exist
            }
        }
}
# Create FTP Directory/SubDirectory If Needed - Stop
  
# Upload Files - Start
foreach($entry in $SrcFiles)
{
    $SrcFullname = $entry.fullname
    $SrcName = $entry.Name
    $SrcFilePath = $UploadFolder -replace "\\","\\" -replace "\:","\:"
    $DesFile = $FTPHost+$SrcName #$SrcFullname -replace $SrcFilePath,$FTPHost
    $DesFile = $DesFile -replace "\\", "/"
    # Write-Output $DesFile

    $uri = New-Object System.Uri($DesFile)
  #check file exist
  try {
    $checkFileExist = [System.Net.WebRequest]::Create($DesFile);
    $checkFileExist.Credentials = New-Object System.Net.NetworkCredential($FTPUser,$FTPPass);
    $checkFileExist.Method = [System.Net.WebRequestMethods+FTP]::GetFileSize;
    $response = $checkFileExist.GetResponse();
    #Write-Output "exist " + $response
  }
  catch {
    #Write-Output "notExist"
    $webclient.UploadFile($uri, $SrcFullname)
  }
  

  #folder already exists!



  #  Test to see if the file exists by getting the file size by name.
#  If a -1 is returned, the file does not exist.






    
   
}
# Upload Files - Stop
exit
