# Yoga Center Management - Deployment Guide

## Database Connection Issues in Production

### Problem
When deploying to production, you may encounter this error:
```json
{
  "message": "The maximum number of retries (3) was exceeded while executing database operations with 'SqlServerRetryingExecutionStrategy'. See the inner exception for the most recent failure.",
  "statusCode": 500
}
```

### Solutions

#### 1. **Check SQL Server Installation**
Make sure SQL Server Express is installed on the production machine:
```powershell
# Check if SQL Server is running
Get-Service -Name "*SQL*"

# Check available instances
sqlcmd -L
```

#### 2. **Update Connection String for Production**
If your production server has a different SQL Server instance, update the connection string in `appsettings.Production.json`:

**Option A: LocalDB (Recommended for development/testing)**
```json
"ConnectionStrings": {
  "YGC": "Server=(localdb)\\SQLEXPRESS;Database=YGC2;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true;Connection Timeout=60;Command Timeout=60;Max Pool Size=200;Min Pool Size=10;Pooling=true;Application Name=YogaCenterManagement"
}
```

**Option B: Named Instance**
```json
"ConnectionStrings": {
  "YGC": "Server=YOUR_SERVER_NAME\\SQLEXPRESS;Database=YGC2;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true;Connection Timeout=60;Command Timeout=60;Max Pool Size=200;Min Pool Size=10;Pooling=true;Application Name=YogaCenterManagement"
}
```

**Option C: SQL Server Authentication**
```json
"ConnectionStrings": {
  "YGC": "Server=YOUR_SERVER_NAME\\SQLEXPRESS;Database=YGC2;User Id=sa;Password=YOUR_PASSWORD;TrustServerCertificate=True;MultipleActiveResultSets=true;Connection Timeout=60;Command Timeout=60;Max Pool Size=200;Min Pool Size=10;Pooling=true;Application Name=YogaCenterManagement"
}
```

#### 3. **Create Database on Production**
Run the SQL script on your production database:
```bash
sqlcmd -S "YOUR_SERVER_NAME\SQLEXPRESS" -i "0607.sql"
```

#### 4. **Environment Variables (Alternative)**
You can also set the connection string via environment variable:
```bash
setx ConnectionStrings__YGC "Server=(localdb)\SQLEXPRESS;Database=YGC2;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true"
```

#### 5. **IIS Configuration**
If deploying to IIS, make sure:
- Application Pool has proper permissions
- SQL Server service is running
- Windows Authentication is enabled

#### 6. **Test Connection**
Test the database connection before deploying:
```bash
sqlcmd -S "YOUR_SERVER_NAME\SQLEXPRESS" -d "YGC2" -Q "SELECT @@VERSION"
```

### Deployment Steps

1. **Build the application:**
   ```bash
   dotnet publish -c Release -o ./publish
   ```

2. **Copy files to production server**

3. **Update connection string in production**

4. **Create database if it doesn't exist**

5. **Start the application**

### Troubleshooting

- **Check logs** in the application directory
- **Verify SQL Server is running**
- **Test connection string manually**
- **Check Windows Event Viewer** for SQL Server errors
- **Ensure proper permissions** for the application pool user

### Common Issues

1. **SQL Server not running** - Start SQL Server service
2. **Wrong instance name** - Use `sqlcmd -L` to find correct instance
3. **Permission issues** - Grant database access to application pool user
4. **Firewall blocking** - Allow SQL Server through firewall
5. **Database doesn't exist** - Run the SQL script to create it 