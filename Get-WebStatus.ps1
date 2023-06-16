$AddressToTest = "google.com"
$TestLengthInMinutes = 1
$TestIntervalsInSeconds = 2

Function Get-WebStatus($Uri){
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Return (Invoke-WebRequest -Uri $Uri -TimeoutSec 10).StatusCode
}

Write-Host "Starting Online Test" -ForegroundColor Magenta
$Timer = New-TimeSpan -Minutes $TestLengthInMinutes
$Clock = [Diagnostics.Stopwatch]::StartNew()
While($Clock.Elapsed -lt $Timer){
    $StatusCode = Get-WebStatus -Uri $AddressToTest
    Write-Host "Testing $AddressToTest... " -NoNewline
    if($StatusCode -eq "200"){
        Write-Host "Online" -ForegroundColor Green -NoNewline
    }Else{
        Write-Host "Error" -ForegroundColor Red -NoNewline
    }
    Write-Host " $(Get-Date)"
    Start-Sleep -Seconds $TestIntervalsInSeconds
}
Write-Host "Finished Online Test" -ForegroundColor Magenta
