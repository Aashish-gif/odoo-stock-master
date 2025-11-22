@echo off
cd /d "%~dp0src"

REM Fix imports in all JS and JSX files
for /r %%f in (*.js *.jsx) do (
    powershell -Command "(Get-Content '%%f') -replace '@/lib/utils', '../lib/utils' | Set-Content '%%f'"
    powershell -Command "(Get-Content '%%f') -replace '@/components/ui/', '../components/ui/' | Set-Content '%%f'"
    powershell -Command "(Get-Content '%%f') -replace '@/components/', '../components/' | Set-Content '%%f'"
    powershell -Command "(Get-Content '%%f') -replace '@/hooks/', '../hooks/' | Set-Content '%%f'"
    powershell -Command "(Get-Content '%%f') -replace '@/pages/', '../pages/' | Set-Content '%%f'"
)

REM Fix specific paths for different directory levels
cd components
for /r %%f in (*.js *.jsx) do (
    powershell -Command "(Get-Content '%%f') -replace '\.\./lib/utils', '../../lib/utils' | Set-Content '%%f'"
    powershell -Command "(Get-Content '%%f') -replace '\.\./components/ui/', './ui/' | Set-Content '%%f'"
    powershell -Command "(Get-Content '%%f') -replace '\.\./components/', './' | Set-Content '%%f'"
    powershell -Command "(Get-Content '%%f') -replace '\.\./hooks/', '../../hooks/' | Set-Content '%%f'"
)

cd ui
for /r %%f in (*.js *.jsx) do (
    powershell -Command "(Get-Content '%%f') -replace '\.\./lib/utils', '../../../lib/utils' | Set-Content '%%f'"
    powershell -Command "(Get-Content '%%f') -replace '\./ui/', './' | Set-Content '%%f'"
    powershell -Command "(Get-Content '%%f') -replace '\.\./components/ui/', './' | Set-Content '%%f'"
    powershell -Command "(Get-Content '%%f') -replace '\.\./hooks/', '../../../hooks/' | Set-Content '%%f'"
)

echo Import paths fixed!