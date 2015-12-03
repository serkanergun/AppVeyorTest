function ExecuteCommand($command, $command_args)
{
  Write-Host $command $command_args
  Start-Process -FilePath $command -ArgumentList $command_args -Wait -Passthru
}

function InstallPrerequisites($uri, $msi, $install_dir)
{
  Invoke-WebRequest $uri -OutFile $msi

  $install_command = "msiexec.exe"
  $install_args    = "/qn /log log.txt /i $msi TARGETDIR=$install_dir"
  ExecuteCommand $install_command $install_args
}

function main()
{
  try 
  {
    $old_dir = $pwd
    cd "C:/projects"
    InstallPrerequisites "http://sourceforge.net/projects/cppcheck/files/cppcheck/1.71/cppcheck-1.71-x64-Setup.msi/download" "cppcheck.msi" "C:/cppcheck"
	dir
	cd "C:/cppcheck"
	dir
    cd $old_dir
  }
  catch
  {
    throw
  }
}

main