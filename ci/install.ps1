function ExecuteCommand($command, $command_args)
{
  Write-Host $command $command_args
  Start-Process -FilePath $command -ArgumentList $command_args -Wait
}

function InstallPrerequisites($uri, $msi)
{
  Invoke-WebRequest $uri -OutFile $msi

  $install_command = "msiexec.exe"
  $install_args    = "/quiet /norestart /qn /L*V! log.txt /i $msi"
  ExecuteCommand $install_command $install_args
}

function main()
{
  try 
  {
    $old_dir = $pwd
    cd "C:/projects"
    InstallPrerequisites "http://downloads.sourceforge.net/project/cppcheck/cppcheck/1.71/cppcheck-1.71-x64-Setup.msi?r=&ts=1449135605&use_mirror=skylink" "cppcheck.msi" 
    cd $old_dir
  }
  catch
  {
    throw
  }
}

main