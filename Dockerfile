# Use the official Microsoft IIS image
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019

# Set the working directory
WORKDIR /inetpub/wwwroot

# Ensure necessary IIS features are installed
SHELL ["powershell", "-Command"]
RUN Install-WindowsFeature -Name Web-Server, Web-WebServer, Web-Security, Web-ISAPI-Filter, Web-Net-Ext45, Web-Asp-Net45, Web-Mgmt-Console

# Switch to cmd to run icacls
SHELL ["cmd", "/S", "/C"]

# Grant IIS permissions to the IIS_IUSRS group
RUN icacls "C:\inetpub\wwwroot" /grant IIS_IUSRS:(OI)(CI)F /T

# Grant the Network Service permissions to modify IIS settings
RU
