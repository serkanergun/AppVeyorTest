function ExecuteCommand($command, $command_args)
{
  Write-Host $command $command_args
  Start-Process -FilePath $command -ArgumentList $command_args -Wait
}

function InstallPrerequisites($uri, $msi)
{
  Invoke-WebRequest $uri -OutFile $msi

  $install_command = "msiexec.exe"
  $install_args    = "/quiet /norestart /qn /log log.txt /i $msi"
  ExecuteCommand $install_command $install_args
}

function main()
{
  try 
  {
    $old_dir = $pwd
    cd "C:/projects"
    InstallPrerequisites "http://sourceforge.net/projects/cppcheck/files/cppcheck/1.71/cppcheck-1.71-x64-Setup.msi/download" "c:\projects\cppcheck.msi" 
    cd $old_dir
  }
  catch
  {
    throw
  }
}

main