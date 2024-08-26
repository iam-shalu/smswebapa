# Use the official Microsoft IIS image
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019

# Set the working directory
WORKDIR /inetpub/wwwroot

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
