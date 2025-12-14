# Yoga Center Management - Deployment Script
# Run this script to deploy your application

Write-Host "=== Yoga Center Management Deployment ===" -ForegroundColor Green

# Check if SQL Server is running
Write-Host "Checking SQL Server status..." -ForegroundColor Yellow
$sqlServices = Get-Service -Name "*SQL*" | Where-Object { $_.Status -eq "Running" }
if ($sqlServices) {
    Write-Host "SQL Server is running: $($sqlServices.Name -join ', ')" -ForegroundColor Green
} else {
    Write-Host "Warning: SQL Server is not running!" -ForegroundColor Red
    Write-Host "Please start SQL Server before deploying." -ForegroundColor Yellow
}

# Check available SQL Server instances
Write-Host "Checking available SQL Server instances..." -ForegroundColor Yellow
try {
    $instances = sqlcmd -L 2>$null
    if ($instances) {
        Write-Host "Available SQL Server instances:" -ForegroundColor Green
        $instances | ForEach-Object { Write-Host "  - $_" -ForegroundColor Cyan }
    }
} catch {
    Write-Host "Could not retrieve SQL Server instances" -ForegroundColor Yellow
}

# Test database connection
Write-Host "Testing database connection..." -ForegroundColor Yellow
try {
    $result = sqlcmd -S "(localdb)\SQLEXPRESS" -d "YGC2" -Q "SELECT @@VERSION" -h -1 2>$null
    if ($result) {
        Write-Host "Database connection successful!" -ForegroundColor Green
    } else {
        Write-Host "Warning: Could not connect to database YGC2" -ForegroundColor Red
        Write-Host "Please ensure the database exists and is accessible." -ForegroundColor Yellow
    }
} catch {
    Write-Host "Warning: Database connection test failed" -ForegroundColor Red
}

# Check if publish folder exists
if (Test-Path "./publish") {
    Write-Host "Publish folder found!" -ForegroundColor Green
    
    # Show deployment options
    Write-Host "`nDeployment Options:" -ForegroundColor Cyan
    Write-Host "1. Run locally (dotnet run)" -ForegroundColor White
    Write-Host "2. Deploy to IIS" -ForegroundColor White
    Write-Host "3. Deploy to Azure App Service" -ForegroundColor White
    Write-Host "4. Deploy to Docker" -ForegroundColor White
    
    $choice = Read-Host "`nSelect deployment option (1-4)"
    
    switch ($choice) {
        "1" {
            Write-Host "Starting application locally..." -ForegroundColor Green
            Set-Location "./publish"
            dotnet Api.dll
        }
        "2" {
            Write-Host "IIS Deployment Instructions:" -ForegroundColor Cyan
            Write-Host "1. Copy the 'publish' folder to your IIS web root" -ForegroundColor White
            Write-Host "2. Create a new Application Pool" -ForegroundColor White
            Write-Host "3. Create a new Website/Application pointing to the publish folder" -ForegroundColor White
            Write-Host "4. Ensure the Application Pool has access to SQL Server" -ForegroundColor White
            Write-Host "5. Update connection string in appsettings.Production.json if needed" -ForegroundColor White
        }
        "3" {
            Write-Host "Azure App Service Deployment:" -ForegroundColor Cyan
            Write-Host "1. Install Azure CLI" -ForegroundColor White
            Write-Host "2. Run: az login" -ForegroundColor White
            Write-Host "3. Run: az webapp deployment source config-zip --resource-group YOUR_RG --name YOUR_APP --src publish.zip" -ForegroundColor White
        }
        "4" {
            Write-Host "Docker Deployment:" -ForegroundColor Cyan
            Write-Host "1. Create a Dockerfile in the root directory" -ForegroundColor White
            Write-Host "2. Build: docker build -t yogacenter ." -ForegroundColor White
            Write-Host "3. Run: docker run -p 8080:80 yogacenter" -ForegroundColor White
        }
        default {
            Write-Host "Invalid choice. Please run the script again." -ForegroundColor Red
        }
    }
} else {
    Write-Host "Publish folder not found! Please run 'dotnet publish Api.csproj -c Release -o ./publish' first." -ForegroundColor Red
}

Write-Host "`nDeployment script completed!" -ForegroundColor Green 