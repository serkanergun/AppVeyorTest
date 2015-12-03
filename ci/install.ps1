function main()
{
  try 
  {
    $depFolder = "c:\deps"

    $depends = @{
      "cppcheck" = "http://downloads.sourceforge.net/project/cppcheck/cppcheck/1.71/cppcheck-1.71-x64-Setup.msi?r=&ts=1449135605&use_mirror=skylink"	
    }

    $old_dir = $pwd

	If (!(Test-Path -Path $depFolder)){
	  Write-Host "Creating Folder: $depFolder"
	  New-Item -ItemType directory -Path $depFolder | Out-Null
	}
    cd $depFolder
    foreach ($depend in $depends.GetEnumerator()) {
      If (!(Test-Path "$depFolder\$($depend.Name).msi")){
	    Write-Host "Downloading $($depend.Name)"
        (new-object net.webclient).DownloadFile($($depend.Value), "$depFolder\$($depend.Name).msi")
      }
      Write-Host "Installing $($depend.Name)"
      Start-Process -FilePath "msiexec.exe" -ArgumentList "/quiet /norestart /qn /L*V! $($depend.Name).log /i $($depend.Name).msi" -Wait
    }

    cd $old_dir
  }
  catch
  {
    throw
  }
}

main