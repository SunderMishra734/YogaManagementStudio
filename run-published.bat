@echo off
echo Starting Yoga Center Management Application...
echo.
echo Make sure SQL Server is running before starting the application.
echo.
cd publish
dotnet Api.dll
pause 