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

# Grant the Application Pool Identity permissions to modify IIS settings
RUN icacls "C:\inetpub\wwwroot" /grant "IIS APPPOOL\DefaultAppPool":(OI)(CI)F /T

# Switch back to PowerShell
SHELL ["powershell", "-Command"]

# Copy the .NET application files to the container
COPY ./ /inetpub/wwwroot

# Expose port 80
EXPOSE 80

# Start IIS
CMD ["C:\\ServiceMonitor.exe", "w3svc"]
