# Use the official Microsoft IIS image
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019

# Set the working directory
WORKDIR /inetpub/wwwroot

# Ensure the necessary services are enabled and started
SHELL ["cmd", "/S", "/C"]
RUN sc config trustedinstaller start=auto && sc start trustedinstaller

# Install IIS
RUN dism.exe /online /enable-feature /all /featurename:IIS-WebServerRole /featurename:IIS-WebServer /featurename:IIS-ISAPIFilter /featurename:IIS-ISAPIExtensions /featurename:IIS-NetFxExtensibility /featurename:IIS-ASPNET45 /featurename:IIS-ManagementConsole /NoRestart

# Grant IIS permissions to the IIS_IUSRS group
RUN icacls "C:\inetpub\wwwroot" /grant IIS_IUSRS:F /T

# Grant the Application Pool Identity permissions to modify IIS settings
RUN icacls "C:\inetpub\wwwroot" /grant "IIS APPPOOL\DefaultAppPool":(OI)(CI)F /T

# Copy the .NET application files to the container
COPY ./ /inetpub/wwwroot

# Expose port 80
EXPOSE 80

# Start IIS
CMD ["C:\\ServiceMonitor.exe", "w3svc"]
