$py_ver = "3.7.3"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
if (Test-Path -Path "c:/Temp/python-$py_ver.exe") {
    Write-Host "Python has already been downloaded."
}    else {
    Write-Host "Downloading Python ..."
    if (-not (Test-Path -Path "c:\Temp")){
       New-Item -Path "c:\" -Name "Temp"  -ItemType Directory
    }
    Invoke-WebRequest -Uri "https://www.python.org/ftp/python/$py_ver/python-$py_ver-amd64.exe" -OutFile "c:/Temp/python-$py_ver.exe"
}
if (Test-Path -Path 'C:\Program Files\Python37'){
    Write-Host "Python already installed."
} else {
    Write-Host "Installing Python ..."
Start-Process -FilePath "c:\Temp\python-$py_ver.exe" -ArgumentList "/quiet InstallAllUsers=0 PrependPath=1 Include_test=0"
}

Write-Host "Verifying Python is in Env Var"
if ( Get-ChildItem Env:\Path | Where-Object{$_.value -like "*python*"} | Test-Path){
    Write-Host "Python is configured properly"
} else {
    Write-Host "Add Python to your envriomental variables then rerun script"
}
Write-Host "Running Script ..."
python.exe .\py.py