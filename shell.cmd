@echo off
mode con cols=35 lines=25 >nul
chcp 65001 >nul
title ^ 
echo Loading...
echo ________________________
echo.
echo        -----___----         Z
echo       ^| ^|  /   ^|  / /     z
echo   --------------------- z
echo    ^| ^|  ^|____^|    ^| ^|
echo     三^|  -   -    ^|三^ 

echo     ^|_^|---------^|_^|
echo        ^|_________^|--^|
echo        / ______ ^| ^|--________^|
echo      /  ^|______^|   ^|   -----___^|
echo     ^| ^|  ______  ^|  ^|-------___^|
echo    ^|__^| ^|______^| ^|__^|
echo     ^|______________^|
echo        ^|  ^|  ^|  ^|
echo        ^|__^|  ^|__^|
echo.
timeout /t 1 >nul
echo ________________________
echo Loading shell...
echo Loading script...
echo Loading lib...
start "" "%cd%\res\lib\player2.exe"
timeout /t 1 >nul
echo Loading language...

set "LANG_FILE=%cd%\res\lang\setting"
if not exist "%cd%\res\lang" mkdir "%cd%\res\lang"

if not exist "%LANG_FILE%" (
    powershell -NoProfile -Command ^
      "Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing;" ^
      "$f = New-Object System.Windows.Forms.Form;" ^
      "$f.Text = 'Language'; $f.Size = New-Object System.Drawing.Size(320,180);" ^
      "$f.StartPosition = 'CenterScreen'; $f.FormBorderStyle = 'FixedDialog';" ^
      "$f.MaximizeBox = $false; $f.MinimizeBox = $false;" ^
      "$l = New-Object System.Windows.Forms.Label; $l.Text = 'language?';" ^
      "$l.Location = New-Object System.Drawing.Point(20,15); $l.Size = New-Object System.Drawing.Size(260,25); $f.Controls.Add($l);" ^
      "$c = New-Object System.Windows.Forms.ComboBox;" ^
      "$c.DropDownStyle = 'DropDownList';" ^
      "$c.Location = New-Object System.Drawing.Point(20,50); $c.Size = New-Object System.Drawing.Size(265,28);" ^
      "[void]$c.Items.Add('English|en_US');" ^
      "[void]$c.Items.Add('简体中文|zh_CN');" ^
      "[void]$c.Items.Add('繁體中文|zh_TW');" ^
      "[void]$c.Items.Add('日本語|ja_JP');" ^
      "[void]$c.Items.Add('한국어|ko_KR');" ^
      "[void]$c.Items.Add('Français|fr_FR');" ^
      "[void]$c.Items.Add('Deutsch|de_DE');" ^
      "$c.SelectedIndex = 0;" ^
      "$f.Controls.Add($c);" ^
      "$b = New-Object System.Windows.Forms.Button;" ^
      "$b.Text = 'OK'; $b.Location = New-Object System.Drawing.Point(210,95); $b.Size = New-Object System.Drawing.Size(75,30);" ^
      "$b.DialogResult = 'OK'; $f.Controls.Add($b);" ^
      "$f.AcceptButton = $b;" ^
      "[void]$f.ShowDialog();" ^
      "$lang = $c.SelectedItem.ToString().Split('|')[1];" ^
      "[System.IO.File]::WriteAllText($env:LANG_FILE, $lang, (New-Object System.Text.UTF8Encoding $false))"
    set "LANG_FILE=%cd%\res\lang\setting"
)

set /p LANG=<"%LANG_FILE%"
echo Language: %LANG%
echo Start program

if /i "%LANG%"=="en_US" goto :en
if /i "%LANG%"=="zh_CN" goto :zh
if /i "%LANG%"=="zh_TW" goto :zhtw
if /i "%LANG%"=="ja_JP" goto :ja
if /i "%LANG%"=="ko_KR" goto :ko
if /i "%LANG%"=="fr_FR" goto :fr
if /i "%LANG%"=="de_DE" goto :de
goto :zh

:en
call "%cd%\res\lib\en_US.bat"
goto :eof

:zh
call "%cd%\res\lib\zh_CN.bat"
goto :eof

:zhtw
call "%cd%\res\lib\zh_TW.bat"
goto :eof

:ja
call "%cd%\res\lib\ja_JP.bat"
goto :eof

:ko
call "%cd%\res\lib\ko_KR.bat"
goto :eof

:fr
call "%cd%\res\lib\fr_FR.bat"
goto :eof

:de
call "%cd%\res\lib\de_DE.bat"
goto :eof
