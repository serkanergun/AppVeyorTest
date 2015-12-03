function install_msi($folder, $name, $url)
{
  If (!(Test-Path "$folder\$name.msi")){
	Write-Host "Downloading $name"
	(new-object net.webclient).DownloadFile($url, "$folder\$name.msi")
  }
  Write-Host "Installing $name"
  Start-Process -FilePath "msiexec.exe" -ArgumentList "/quiet /norestart /qn /L*V! $name.log /i $name.msi" -Wait
}

function install_zip($folder, $name, $url, $dir)
{
  If (!(Test-Path "$folder\$name.zip")){
	Write-Host "Downloading $name"
	(new-object net.webclient).DownloadFile($url, "$folder\$name.zip")
    
	Write-Host "Extracting $name"
    Start-Process -FilePath "7z.exe" -ArgumentList "x $name.zip -o$folder\$dir -y" -Wait
  }
}

function main()
{
  try 
  {
    $depFolder = "c:\deps"

    $depends = @{
      "cppcheck" = @("msi", "http://downloads.sourceforge.net/project/cppcheck/cppcheck/1.71/cppcheck-1.71-x64-Setup.msi?r=&ts=1449135605&use_mirror=skylink")
	  "Eigen" = @("zip", "http://bitbucket.org/eigen/eigen/get/3.2.7.zip", ".")
    }

    $old_dir = $pwd

    If (!(Test-Path -Path $depFolder)){
      Write-Host "Creating Folder: $depFolder"
      New-Item -ItemType directory -Path $depFolder | Out-Null
    }
    cd $depFolder
    foreach ($depend in $depends.GetEnumerator()) {
      $name = $($depend.Name)
      $vals = $($depend.Value)
      switch ($vals[0]) {
        "msi" {
          install_msi $depFolder $name $vals[1] 
        }
		"zip" {
		  install_zip $depFolder $name $vals[1] $vals[2]
		}
      }
    }

    cd $old_dir
  }
  catch
  {
    throw
  }
}

main