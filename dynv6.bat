﻿:: 隐藏运行窗口
@echo off
if "%1" == "h" goto begin
mshta vbscript:createobject("wscript.shell").run("""%~f0"" h",0)(window.close)&&exit
:begin
REM

@echo off
setlocal EnableDelayedExpansion
chcp 437 >nul
title Dynv6 Auto Upload Script

:: 使用前可将脚本加载于 组策略-本地计算机策略-计算机配置-Windows设置-启动

set token=rF34sbvxzstNUmRsHy_3VXNf_iBcEx
set hostname=zhangjun-g510.dynv6.net
set daemon=3600

:: 联想G510 win7，避免temp在ramdisk从而bitsadmin报错
:: set tmp=%tmpp%

:: 预设 
set "MsgBox=call :MsgBox"
set "Url=http://dynv6.com/api/update?hostname=%hostname%&ipv6=^!ipv6^!&token=%token%"

:: 检测 
bitsadmin /? >nul || (%MsgBox% "bitsadmin.exe is missing." & exit /b 1)
timeout /? >nul || (%MsgBox% "timeout.exe is missing." & exit /b 1)

:: 预设命令
:: netsh advfirewall firewall set rule name="远程桌面 - 用户模式(TCP-In)" new enable=yes
:: netsh advfirewall firewall set rule name="远程桌面 - 用户模式(UDP-In)" new enable=yes

:loop

:: 获取IPv6 
set "ipv6.old=%ipv6%"
for /f "tokens=1,* delims=:" %%a in ('ipconfig ^| findstr /i /r /c:"Temporary IPv6.*" 2^>nul') do (
	set "ipv6=%%b" & set "ipv6=!ipv6:~1!"
	goto :out1
)
:out1

:: 有变更时，上传 
if not "%ipv6%"=="%ipv6.old%" (
	>"%tmp%\dynv6.log" echo;
	echo "%Url%"
	bitsadmin /transfer %random% /download "%Url%" "%tmp%\dynv6.log"
	findstr /i "unchanged updated" "%tmp%\dynv6.log" || (
		%MsgBox% "Some errors have occurred and you can check the log file for information.  %tmp%\dynv6.log"
	)

)

:: 刷新间隔 
timeout /t %daemon% /nobreak >nul
goto :loop


:MsgBox
mshta vbscript:execute^("msgbox(""%~0"",64,""dynv6"")(close)"^)
goto :EOF
