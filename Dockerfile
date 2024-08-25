# Use the official Microsoft IIS image
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019

# Set the working directory
WORKDIR /inetpub/wwwroot

# Copy the .NET application files to the container
COPY ./ /inetpub/wwwroot

# Expose port 80
EXPOSE 80

# Start IIS
CMD ["C:\\ServiceMonitor.exe", "w3svc"]
