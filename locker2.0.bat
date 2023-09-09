@cls

@echo off

title Hide encrypted folder V2.0.0
mode con cols=45 lines=10
chcp 65001 1>nul 2>nul 
rem "密码保存在CMD locker\password.properties当中有漏洞"
rem "该脚本至少运行2次才能正常使用"
:home
echo ====================================
echo 欢迎使用Hide encrypted folder V2.1.0
echo ====================================

if exist "CMD locker" goto unlock
if not exist private goto mdlocker
goto confirm

:hidden
attrib +h +s locker2.0.bat
goto home


:confirm
if not exist "private\password.properties" goto PASSWORD
echo 你确定要加密private文件夹吗？（请输入Y/N）
set /p "cho=>"
if %cho%==Y goto lock
if %cho%==y goto lock
if %cho%==n goto end
if %cho%==N goto end
echo invalid choice.
goto confirm

:lock
ren private "CMD locker"
attrib +h +s "CMD locker"
echo folder locked
goto end

:PASSWORD
if not exist private goto mdlocker
echo 请设置密码
set /p "pass=>"
echo password=%pass% > private\password.properties
timeout -t 1 -nobreak
attrib +s +h private\password.properties
echo 密码设置成功
goto end

:unlock
for /f "tokens=1* delims== usebackq" %%i in ("CMD locker\password.properties") do if "%%i"=="password" set password=%%j
echo 请输入密码来解锁文件夹
set /p "pass=>"
if not %pass%==%password% goto fail
attrib -h -s "CMD locker"
ren "CMD locker" private
echo folder unlocked successfull
goto end

:fail
echo invalid password
echo 请重试...
timeout -nobreak -t 5
cls
goto home

:mdlocker
set /p choose=是否创建加密文件夹？（请输入Y/N）
if %choose%==Y goto mdlocker2
if %choose%==y goto mdlocker2
if %choose%==n goto end
if %choose%==N goto end
echo invalid choice.
goto end
:mdlocker2
md private
timeout -t 3 -nobreak
echo private created successfully
goto PASSWORD

:end

pause