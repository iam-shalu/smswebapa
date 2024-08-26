# Use the official Microsoft IIS image
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019

# Set the working directory
WORKDIR /inetpub/wwwroot

# Ensure necessary IIS features are installed
SHELL ["powershell", "-Command"]
RUN Install-WindowsFeature -Name Web-Server, Web-WebServer, Web-Security, Web-ISAPI-Filter, Web-Net-Ext45, Web-Asp-Net45, Web-Mgmt-Console

# Ensure the necessary permissions are set
RUN icacls "C:\inetpub\wwwroot" /grant IIS_IUSRS:(OI)(CI)F /T || exit 0
RUN icacls "C:\inetpub\wwwroot" /grant "IIS APPPOOL\DefaultAppPool":(OI)(CI)F /T || exit 0

# Copy the .NET application files to the container
COPY ./ /inetpub/wwwroot

# Expose port 80
EXPOSE 80

# Start IIS
CMD ["C:\\ServiceMonitor.exe", "w3svc"]
