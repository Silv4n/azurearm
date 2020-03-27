# Create folder
New-Item -ItemType Directory -Name 'AZDEPLOYFOLDERLETSGO' -Path 'C:\'

# Create file
New-Item -ItemType File -Name 'OMEGALUL.txt' -Path 'C:\AZDEPLOYFOLDERLETSGO'

# Enable WinRM via HTTPS
Enable-PSRemoting -Force -SkipNetworkProfileCheck
New-NetFirewallRule -Name "Allow WinRM HTTPS" -DisplayName "WinRM HTTPS" -Enabled True -Profile Any -Action Allow -Direction Inbound -LocalPort 5986 -Protocol TCP
$thumbprint = (New-SelfSignedCertificate -DnsName $env:COMPUTERNAME -CertStoreLocation Cert:\LocalMachine\My).Thumbprint
$command = "winrm create winrm/config/Listener?Address=*+Transport=HTTPS @{Hostname=""$env:computername""; CertificateThumbprint=""$thumbprint""}"
cmd.exe /C $command

# Enable RDP on Port 33899
New-NetFirewallRule -Name "Allow RDP Custom Port" -DisplayName "RDP 33899" -Enabled True -Profile Any -Action Allow -Direction Inbound -LocalPort 33899 -Protocol TCP