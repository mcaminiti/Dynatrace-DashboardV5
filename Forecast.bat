@setlocal enableextensions enabledelayedexpansion
@echo off
copy .\*ForecastAnalysis.json .\Transform\
REM Common vars
set /a "trafficfactor = %3"
set "titledate="
set "filterdate="
set "startdate="
set "enddate="
set "tenant="
set "owner="
set "appname="
set "laststep="
set "firststep="
set "revenue="
REM Revenue vars
set /a "rev1 = 0"
set /a "rev2 = 0"
set /a "rev3 = 0"
set /a "rev4 = 0"
set /a "rev5 = 0"
set /a "acv1 = 0"
set /a "acv2 = 0"
set /a "acv3 = 0"
set /a "acv4 = 0"
set /a "acv5 = 0"
set /a "riskrev1 = 0"
set /a "riskrev2 = 0"
set /a "riskrev3 = 0"
set /a "riskrev4 = 0"
set /a "riskrev5 = 0"
set /a "lostrev1 = 0"
set /a "lostrev2 = 0"
set /a "lostrev3 = 0"
set /a "lostrev4 = 0"
set /a "lostrev5 = 0"
set /a "nur1 = 0"
set /a "nur2 = 0"
set /a "nur3 = 0"
set /a "nur4 = 0"
set /a "nur5 = 0"
REM Funnel vars
set /a "funconv1 = 0"
set /a "funconv2 = 0"
set /a "funconv3 = 0"
set /a "funconv4 = 0"
set /a "funconv5 = 0"
set /a "funaban1 = 0"
set /a "funaban2 = 0"
set /a "funaban3 = 0"
set /a "funaban4 = 0"
set /a "funaban5 = 0"
set /a "funvisit1 = 0"
set /a "funvisit2 = 0"
set /a "funvisit3 = 0"
set /a "funvisit4 = 0"
set /a "funvisit5 = 0"
set /a "fnosu1 = 0"
set /a "fnosu2 = 0"
set /a "fnosu3 = 0"
set /a "fnosu4 = 0"
set /a "fnosu5 = 0"
set /a "fundur1 = 0"
set /a "fundur2 = 0"
set /a "fundur3 = 0"
set /a "fundur4 = 0"
set /a "fundur5 = 0"
REM Application vars
set /a "anosu1 = 0"
set /a "anosu2 = 0"
set /a "anosu3 = 0"
set /a "anosu4 = 0"
set /a "anosu5 = 0"
set /a "anotu1 = 0"
set /a "anotu2 = 0"
set /a "anotu3 = 0"
set /a "anotu4 = 0"
set /a "anotu5 = 0"
set /a "anofu1 = 0"
set /a "anofu2 = 0"
set /a "anofu3 = 0"
set /a "anofu4 = 0"
set /a "anofu5 = 0"
set /a "appdur1 = 0"
set /a "appdur2 = 0"
set /a "appdur3 = 0"
set /a "appdur4 = 0"
set /a "appdur5 = 0"
set /a "apperr1 = 0"
set /a "apperr2 = 0"
set /a "apperr3 = 0"
set /a "apperr4 = 0"
set /a "apperr5 = 0"
set /a "line = 0"
REM Get env data from config file
set "dashboardkey=%2"
if not defined dashboardkey set /p dashboardkey="Enter Dashboard Key: "
if exist ./\%dashboardkey%.cfg (
for /f "tokens=*" %%a in (./\%dashboardkey%.cfg) do (
    set /a "line = line + 1"
    if !line!==1 set tenant=%%a
    if !line!==2 set owner=%%a
    if !line!==4 set appname=%%a
    if !line!==5 set revenue=%%a
    if !line!==10 set firststep=%%a
    if !line!==10 set laststep=%%a
    if !line!==12 set laststep=%%a
    if !line!==14 set laststep=%%a
    if !line!==16 set laststep=%%a
    if !line!==18 set laststep=%%a
    if !line!==20 set laststep=%%a
    if !line!==22 set laststep=%%a
    if !line!==24 set laststep=%%a
    if !line!==26 set laststep=%%a
    if !line!==28 set laststep=%%a
)
)
REM Cleanup config data
set appname=!appname: =%%20!
set laststep=!laststep: =%%20!
set laststep=!laststep:""=%%22%%22!
set laststep=!laststep:"=%%22!
set firststep=!firststep: =%%20!
set firststep=!firststep:""=%%22%%22!
set firststep=!firststep:"=%%22!

REM Revenue Forecasting

REM Revenue
call GetDate 0
set "startdate=%filterdate%"
set "titledate=%filterdate%"
call GetDate 7
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20sum(!revenue!)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk1.json
set "startdate=%enddate%"
call GetDate 14
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20sum(!revenue!)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk2.json
set "startdate=%enddate%"
call GetDate 21
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20sum(!revenue!)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk3.json
set "startdate=%enddate%"
call GetDate 28
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20sum(!revenue!)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk4.json
call GetDate 35
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20sum(!revenue!)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk5.json

powershell -Command "Get-ChildItem -Path ./Transform\jk*.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern '\]\]\}') {(Get-Content $_ | ForEach {$_ -replace '\]\]\}', ''}) | Set-Content $_ -encoding ASCII}}"

set /p rev1=<./Transform\jk1.json
set rev1=!rev1:~61!
set /p rev2=<./Transform\jk2.json
set rev2=!rev2:~61!
set /p rev3=<./Transform\jk3.json
set rev3=!rev3:~61!
set /p rev4=<./Transform\jk4.json
set rev4=!rev4:~61!
set /p rev5=<./Transform\jk5.json
set rev5=!rev5:~61!

REM Average Cart Value
call GetDate 0
set "startdate=%filterdate%"
call GetDate 7
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20avg(!revenue!)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk1.json
set "startdate=%enddate%"
call GetDate 14
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20avg(!revenue!)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk2.json
set "startdate=%enddate%"
call GetDate 21
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20avg(!revenue!)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk3.json
set "startdate=%enddate%"
call GetDate 28
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20avg(!revenue!)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk4.json
call GetDate 35
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20avg(!revenue!)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk5.json

powershell -Command "Get-ChildItem -Path ./Transform\jk*.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern '\]\]\}') {(Get-Content $_ | ForEach {$_ -replace '\]\]\}', ''}) | Set-Content $_ -encoding ASCII}}"

set /p acv1=<./Transform\jk1.json
set acv1=!acv1:~61!
set /p acv2=<./Transform\jk2.json
set acv2=!acv2:~61!
set /p acv3=<./Transform\jk3.json
set acv3=!acv3:~61!
set /p acv4=<./Transform\jk4.json
set acv4=!acv4:~61!
set /p acv5=<./Transform\jk5.json
set acv5=!acv5:~61!

REM Risk Revenue
call GetDate 0
set "startdate=%filterdate%"
call GetDate 7
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20sum(!revenue!)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20userExperienceScore%%21%%3D%%22SATISFIED%%22%%20and%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk1.json
set "startdate=%enddate%"
call GetDate 14
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20sum(!revenue!)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20userExperienceScore%%21%%3D%%22SATISFIED%%22%%20and%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk2.json
set "startdate=%enddate%"
call GetDate 21
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20sum(!revenue!)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20userExperienceScore%%21%%3D%%22SATISFIED%%22%%20and%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk3.json
set "startdate=%enddate%"
call GetDate 28
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20sum(!revenue!)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20userExperienceScore%%21%%3D%%22SATISFIED%%22%%20and%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk4.json
call GetDate 35
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20sum(!revenue!)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20userExperienceScore%%21%%3D%%22SATISFIED%%22%%20and%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk5.json

powershell -Command "Get-ChildItem -Path ./Transform\jk*.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern '\]\]\}') {(Get-Content $_ | ForEach {$_ -replace '\]\]\}', ''}) | Set-Content $_ -encoding ASCII}}"

set /p riskrev1=<./Transform\jk1.json
set riskrev1=!riskrev1:~61!
set /p riskrev2=<./Transform\jk2.json
set riskrev2=!riskrev2:~61!
set /p riskrev3=<./Transform\jk3.json
set riskrev3=!riskrev3:~61!
set /p riskrev4=<./Transform\jk4.json
set riskrev4=!riskrev4:~61!
set /p riskrev5=<./Transform\jk5.json
set riskrev5=!riskrev5:~61!

REM Lost Revenue
call GetDate 0
set "startdate=%filterdate%"
call GetDate 7
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20sum(!revenue!)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20not%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk1.json
set "startdate=%enddate%"
call GetDate 14
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20sum(!revenue!)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20not%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk2.json
set "startdate=%enddate%"
call GetDate 21
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20sum(!revenue!)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20not%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk3.json
set "startdate=%enddate%"
call GetDate 28
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20sum(!revenue!)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20not%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk4.json
call GetDate 35
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20sum(!revenue!)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20not%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk5.json

powershell -Command "Get-ChildItem -Path ./Transform\jk*.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern '\]\]\}') {(Get-Content $_ | ForEach {$_ -replace '\]\]\}', ''}) | Set-Content $_ -encoding ASCII}}"

set /p lostrev1=<./Transform\jk1.json
set lostrev1=!lostrev1:~61!
set /p lostrev2=<./Transform\jk2.json
set lostrev2=!lostrev2:~61!
set /p lostrev3=<./Transform\jk3.json
set lostrev3=!lostrev3:~61!
set /p lostrev4=<./Transform\jk4.json
set lostrev4=!lostrev4:~61!
set /p lostrev5=<./Transform\jk5.json
set lostrev5=!lostrev5:~61!

REM New User Revenue
call GetDate 0
set "startdate=%filterdate%"
call GetDate 7
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20sum(!revenue!)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!laststep!%%20and%%20newUser%%20is%%20true%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk1.json
set "startdate=%enddate%"
call GetDate 14
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20sum(!revenue!)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!laststep!%%20and%%20newUser%%20is%%20true%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk2.json
set "startdate=%enddate%"
call GetDate 21
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20sum(!revenue!)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!laststep!%%20and%%20newUser%%20is%%20true%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk3.json
set "startdate=%enddate%"
call GetDate 28
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20sum(!revenue!)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!laststep!%%20and%%20newUser%%20is%%20true%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk4.json
call GetDate 35
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20sum(!revenue!)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!laststep!%%20and%%20newUser%%20is%%20true%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk5.json

powershell -Command "Get-ChildItem -Path ./Transform\jk*.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern '\]\]\}') {(Get-Content $_ | ForEach {$_ -replace '\]\]\}', ''}) | Set-Content $_ -encoding ASCII}}"

set /p nur1=<./Transform\jk1.json
set nur1=!nur1:~61!
set /p nur2=<./Transform\jk2.json
set nur2=!nur2:~61!
set /p nur3=<./Transform\jk3.json
set nur3=!nur3:~61!
set /p nur4=<./Transform\jk4.json
set nur4=!nur4:~61!
set /p nur5=<./Transform\jk5.json
set nur5=!nur5:~61!

REM Funnel Forecasting

REM Conversions
call GetDate 0
set "startdate=%filterdate%"
set "titledate=%filterdate%"
call GetDate 7
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk1.json
set "startdate=%enddate%"
call GetDate 14
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk2.json
set "startdate=%enddate%"
call GetDate 21
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk3.json
set "startdate=%enddate%"
call GetDate 28
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk4.json
call GetDate 35
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk5.json

powershell -Command "Get-ChildItem -Path ./Transform\jk*.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern '\]\]\}') {(Get-Content $_ | ForEach {$_ -replace '\]\]\}', ''}) | Set-Content $_ -encoding ASCII}}"

set /p funconv1=<./Transform\jk1.json
set funconv1=!funconv1:~61!
set /p funconv2=<./Transform\jk2.json
set funconv2=!funconv2:~61!
set /p funconv3=<./Transform\jk3.json
set funconv3=!funconv3:~61!
set /p funconv4=<./Transform\jk4.json
set funconv4=!funconv4:~61!
set /p funconv5=<./Transform\jk5.json
set funconv5=!funconv5:~61!

REM Abandons
call GetDate 0
set "startdate=%filterdate%"
call GetDate 7
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20not%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk1.json
set "startdate=%enddate%"
call GetDate 14
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20not%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk2.json
set "startdate=%enddate%"
call GetDate 21
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20not%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk3.json
set "startdate=%enddate%"
call GetDate 28
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20not%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk4.json
call GetDate 35
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20not%%20!laststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk5.json

powershell -Command "Get-ChildItem -Path ./Transform\jk*.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern '\]\]\}') {(Get-Content $_ | ForEach {$_ -replace '\]\]\}', ''}) | Set-Content $_ -encoding ASCII}}"

set /p funaban1=<./Transform\jk1.json
set funaban1=!funaban1:~61!
set /p funaban2=<./Transform\jk2.json
set funaban2=!funaban2:~61!
set /p funaban3=<./Transform\jk3.json
set funaban3=!funaban3:~61!
set /p funaban4=<./Transform\jk4.json
set funaban4=!funaban4:~61!
set /p funaban5=<./Transform\jk5.json
set funaban5=!funaban5:~61!

REM Funnel Visits
call GetDate 0
set "startdate=%filterdate%"
call GetDate 7
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!firststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk1.json
set "startdate=%enddate%"
call GetDate 14
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!firststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk2.json
set "startdate=%enddate%"
call GetDate 21
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!firststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk3.json
set "startdate=%enddate%"
call GetDate 28
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!firststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk4.json
call GetDate 35
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!firststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk5.json

powershell -Command "Get-ChildItem -Path ./Transform\jk*.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern '\]\]\}') {(Get-Content $_ | ForEach {$_ -replace '\]\]\}', ''}) | Set-Content $_ -encoding ASCII}}"

set /p funvisit1=<./Transform\jk1.json
set funvisit1=!funvisit1:~61!
set /p funvisit2=<./Transform\jk2.json
set funvisit2=!funvisit2:~61!
set /p funvisit3=<./Transform\jk3.json
set funvisit3=!funvisit3:~61!
set /p funvisit4=<./Transform\jk4.json
set funvisit4=!funvisit4:~61!
set /p funvisit5=<./Transform\jk5.json
set funvisit5=!funvisit5:~61!

REM Number of Satisfied Users
call GetDate 0
set "startdate=%filterdate%"
call GetDate 7
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20userExperienceScore%%3D%%22SATISFIED%%22%%20and%%20!firststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk1.json
set "startdate=%enddate%"
call GetDate 14
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20userExperienceScore%%3D%%22SATISFIED%%22%%20and%%20!firststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk2.json
set "startdate=%enddate%"
call GetDate 21
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20userExperienceScore%%3D%%22SATISFIED%%22%%20and%%20!firststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk3.json
set "startdate=%enddate%"
call GetDate 28
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20userExperienceScore%%3D%%22SATISFIED%%22%%20and%%20!firststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk4.json
call GetDate 35
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20userExperienceScore%%3D%%22SATISFIED%%22%%20and%%20!firststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk5.json

powershell -Command "Get-ChildItem -Path ./Transform\jk*.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern '\]\]\}') {(Get-Content $_ | ForEach {$_ -replace '\]\]\}', ''}) | Set-Content $_ -encoding ASCII}}"

set /p fnosu1=<./Transform\jk1.json
set fnosu1=!fnosu1:~61!
set /p fnosu2=<./Transform\jk2.json
set fnosu2=!fnosu2:~61!
set /p fnosu3=<./Transform\jk3.json
set fnosu3=!fnosu3:~61!
set /p fnosu4=<./Transform\jk4.json
set fnosu4=!fnosu4:~61!
set /p fnosu5=<./Transform\jk5.json
set fnosu5=!fnosu5:~61!

REM Session Duration
call GetDate 0
set "startdate=%filterdate%"
call GetDate 7
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20avg(duration)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!firststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk1.json
set "startdate=%enddate%"
call GetDate 14
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20avg(duration)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!firststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk2.json
set "startdate=%enddate%"
call GetDate 21
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20avg(duration)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!firststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk3.json
set "startdate=%enddate%"
call GetDate 28
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20avg(duration)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!firststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk4.json
call GetDate 35
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20avg(duration)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!firststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk5.json

powershell -Command "Get-ChildItem -Path ./Transform\jk*.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern '\]\]\}') {(Get-Content $_ | ForEach {$_ -replace '\]\]\}', ''}) | Set-Content $_ -encoding ASCII}}"

set /p fundur1=<./Transform\jk1.json
set fundur1=!fundur1:~61!
set /p fundur2=<./Transform\jk2.json
set fundur2=!fundur2:~61!
set /p fundur3=<./Transform\jk3.json
set fundur3=!fundur3:~61!
set /p fundur4=<./Transform\jk4.json
set fundur4=!fundur4:~61!
set /p fundur5=<./Transform\jk5.json
set fundur5=!fundur5:~61!

REM Application Forecasting

REM Number of Satisfied Users
call GetDate 0
set "startdate=%filterdate%"
set "titledate=%filterdate%"
call GetDate 7
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20userExperienceScore%%3D%%22SATISFIED%%22%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk1.json
set "startdate=%enddate%"
call GetDate 14
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20userExperienceScore%%3D%%22SATISFIED%%22%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk2.json
set "startdate=%enddate%"
call GetDate 21
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20userExperienceScore%%3D%%22SATISFIED%%22%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk3.json
set "startdate=%enddate%"
call GetDate 28
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20userExperienceScore%%3D%%22SATISFIED%%22%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk4.json
call GetDate 35
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20userExperienceScore%%3D%%22SATISFIED%%22%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk5.json

powershell -Command "Get-ChildItem -Path ./Transform\jk*.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern '\]\]\}') {(Get-Content $_ | ForEach {$_ -replace '\]\]\}', ''}) | Set-Content $_ -encoding ASCII}}"

set /p anosu1=<./Transform\jk1.json
set anosu1=!anosu1:~61!
set /p anosu2=<./Transform\jk2.json
set anosu2=!anosu2:~61!
set /p anosu3=<./Transform\jk3.json
set anosu3=!anosu3:~61!
set /p anosu4=<./Transform\jk4.json
set anosu4=!anosu4:~61!
set /p anosu5=<./Transform\jk5.json
set anosu5=!anosu5:~61!

REM Number of Tolerated Users
call GetDate 0
set "startdate=%filterdate%"
call GetDate 7
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20userExperienceScore%%3D%%22TOLERATED%%22%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk1.json
set "startdate=%enddate%"
call GetDate 14
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20userExperienceScore%%3D%%22TOLERATED%%22%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk2.json
set "startdate=%enddate%"
call GetDate 21
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20userExperienceScore%%3D%%22TOLERATED%%22%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk3.json
set "startdate=%enddate%"
call GetDate 28
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20userExperienceScore%%3D%%22TOLERATED%%22%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk4.json
call GetDate 35
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20userExperienceScore%%3D%%22TOLERATED%%22%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk5.json

powershell -Command "Get-ChildItem -Path ./Transform\jk*.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern '\]\]\}') {(Get-Content $_ | ForEach {$_ -replace '\]\]\}', ''}) | Set-Content $_ -encoding ASCII}}"

set /p anotu1=<./Transform\jk1.json
set anotu1=!anotu1:~61!
set /p anotu2=<./Transform\jk2.json
set anotu2=!anotu2:~61!
set /p anotu3=<./Transform\jk3.json
set anotu3=!anotu3:~61!
set /p anotu4=<./Transform\jk4.json
set anotu4=!anotu4:~61!
set /p anotu5=<./Transform\jk5.json
set anotu5=!anotu5:~61!

REM Number of Frustrated Users
call GetDate 0
set "startdate=%filterdate%"
call GetDate 7
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20userExperienceScore%%3D%%22FRUSTRATED%%22%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk1.json
set "startdate=%enddate%"
call GetDate 14
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20userExperienceScore%%3D%%22FRUSTRATED%%22%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk2.json
set "startdate=%enddate%"
call GetDate 21
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20userExperienceScore%%3D%%22FRUSTRATED%%22%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk3.json
set "startdate=%enddate%"
call GetDate 28
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20userExperienceScore%%3D%%22FRUSTRATED%%22%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk4.json
call GetDate 35
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(usersessionid)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20userExperienceScore%%3D%%22FRUSTRATED%%22%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk5.json

powershell -Command "Get-ChildItem -Path ./Transform\jk*.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern '\]\]\}') {(Get-Content $_ | ForEach {$_ -replace '\]\]\}', ''}) | Set-Content $_ -encoding ASCII}}"

set /p anofu1=<./Transform\jk1.json
set anofu1=!anofu1:~61!
set /p anofu2=<./Transform\jk2.json
set anofu2=!anofu2:~61!
set /p anofu3=<./Transform\jk3.json
set anofu3=!anofu3:~61!
set /p anofu4=<./Transform\jk4.json
set anofu4=!anofu4:~61!
set /p anofu5=<./Transform\jk5.json
set anofu5=!anofu5:~61!

REM Action Duration
call GetDate 0
set "startdate=%filterdate%"
call GetDate 7
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20avg(useraction.duration)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!firststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk1.json
set "startdate=%enddate%"
call GetDate 14
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20avg(useraction.duration)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!firststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk2.json
set "startdate=%enddate%"
call GetDate 21
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20avg(useraction.duration)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!firststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk3.json
set "startdate=%enddate%"
call GetDate 28
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20avg(useraction.duration)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!firststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk4.json
call GetDate 35
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20avg(useraction.duration)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!firststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk5.json

powershell -Command "Get-ChildItem -Path ./Transform\jk*.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern '\]\]\}') {(Get-Content $_ | ForEach {$_ -replace '\]\]\}', ''}) | Set-Content $_ -encoding ASCII}}"

set /p appdur1=<./Transform\jk1.json
set appdur1=!appdur1:~61!
set /p appdur2=<./Transform\jk2.json
set appdur2=!appdur2:~61!
set /p appdur3=<./Transform\jk3.json
set appdur3=!appdur3:~61!
set /p appdur4=<./Transform\jk4.json
set appdur4=!appdur4:~61!
set /p appdur5=<./Transform\jk5.json
set appdur5=!appdur5:~61!

REM Action Errors
call GetDate 0
set "startdate=%filterdate%"
call GetDate 7
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(useraction.errorCount)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!firststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk1.json
set "startdate=%enddate%"
call GetDate 14
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(useraction.errorCount)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!firststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk2.json
set "startdate=%enddate%"
call GetDate 21
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(useraction.errorCount)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!firststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk3.json
set "startdate=%enddate%"
call GetDate 28
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(useraction.errorCount)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!firststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk4.json
call GetDate 35
set "enddate=%filterdate%"
curl -X GET "https://!tenant!/api/v1/userSessionQueryLanguage/table?query=select%%20count(useraction.errorCount)%%20as%%20%%22Revenue%%22%%20from%%20usersession%%20where%%20useraction.application%%3D%%22!appname!%%22%%20and%%20!firststep!%%20and%%20startTime%%20between%%20%%22!enddate!%%22%%20and%%20%%22!startdate!%%22&startTimestamp=1000000000000&explain=false" -H "accept: application/json" -H "Authorization: Api-Token %1" > ./Transform/jk5.json

powershell -Command "Get-ChildItem -Path ./Transform\jk*.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern '\]\]\}') {(Get-Content $_ | ForEach {$_ -replace '\]\]\}', ''}) | Set-Content $_ -encoding ASCII}}"

set /p apperr1=<./Transform\jk1.json
set apperr1=!apperr1:~61!
set /p apperr2=<./Transform\jk2.json
set apperr2=!apperr2:~61!
set /p apperr3=<./Transform\jk3.json
set apperr3=!apperr3:~61!
set /p apperr4=<./Transform\jk4.json
set apperr4=!apperr4:~61!
set /p apperr5=<./Transform\jk5.json
set apperr5=!apperr5:~61!

REM Transform JSON
echo | set /p=Transforming Dashboards

REM Replace all owner names and traffic factor
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'MyEmail') {(Get-Content $_ | ForEach {$_ -replace 'MyEmail', '!owner!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'tdate') {(Get-Content $_ | ForEach {$_ -replace 'tdate', '!titledate!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'tfactor') {(Get-Content $_ | ForEach {$_ -replace 'tfactor', '!trafficfactor!'}) | Set-Content $_ -encoding UTF8}}"

REM Replace Revenue forecast data
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'da313') {(Get-Content $_ | ForEach {$_ -replace 'da313', 'da%dashboardkey%'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'revenue1') {(Get-Content $_ | ForEach {$_ -replace 'revenue1', '!rev1!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'revenue2') {(Get-Content $_ | ForEach {$_ -replace 'revenue2', '!rev2!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'revenue3') {(Get-Content $_ | ForEach {$_ -replace 'revenue3', '!rev3!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'revenue4') {(Get-Content $_ | ForEach {$_ -replace 'revenue4', '!rev4!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'revenue5') {(Get-Content $_ | ForEach {$_ -replace 'revenue5', '!rev5!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'acv1') {(Get-Content $_ | ForEach {$_ -replace 'acv1', '!acv1!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'acv2') {(Get-Content $_ | ForEach {$_ -replace 'acv2', '!acv2!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'acv3') {(Get-Content $_ | ForEach {$_ -replace 'acv3', '!acv3!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'acv4') {(Get-Content $_ | ForEach {$_ -replace 'acv4', '!acv4!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'acv5') {(Get-Content $_ | ForEach {$_ -replace 'acv5', '!acv5!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'riskrev1') {(Get-Content $_ | ForEach {$_ -replace 'riskrev1', '!riskrev1!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'riskrev2') {(Get-Content $_ | ForEach {$_ -replace 'riskrev2', '!riskrev2!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'riskrev3') {(Get-Content $_ | ForEach {$_ -replace 'riskrev3', '!riskrev3!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'riskrev4') {(Get-Content $_ | ForEach {$_ -replace 'riskrev4', '!riskrev4!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'riskrev5') {(Get-Content $_ | ForEach {$_ -replace 'riskrev5', '!riskrev5!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'lostrev1') {(Get-Content $_ | ForEach {$_ -replace 'lostrev1', '!lostrev1!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'lostrev2') {(Get-Content $_ | ForEach {$_ -replace 'lostrev2', '!lostrev2!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'lostrev3') {(Get-Content $_ | ForEach {$_ -replace 'lostrev3', '!lostrev3!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'lostrev4') {(Get-Content $_ | ForEach {$_ -replace 'lostrev4', '!lostrev4!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'lostrev5') {(Get-Content $_ | ForEach {$_ -replace 'lostrev5', '!lostrev5!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'nur1') {(Get-Content $_ | ForEach {$_ -replace 'nur1', '!nur1!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'nur2') {(Get-Content $_ | ForEach {$_ -replace 'nur2', '!nur2!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'nur3') {(Get-Content $_ | ForEach {$_ -replace 'nur3', '!nur3!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'nur4') {(Get-Content $_ | ForEach {$_ -replace 'nur4', '!nur4!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'nur5') {(Get-Content $_ | ForEach {$_ -replace 'nur5', '!nur5!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.

REM Replace Application forecast data
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'anosu1') {(Get-Content $_ | ForEach {$_ -replace 'anosu1', '!anosu1!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'anosu2') {(Get-Content $_ | ForEach {$_ -replace 'anosu2', '!anosu2!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'anosu3') {(Get-Content $_ | ForEach {$_ -replace 'anosu3', '!anosu3!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'anosu4') {(Get-Content $_ | ForEach {$_ -replace 'anosu4', '!anosu4!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'anosu5') {(Get-Content $_ | ForEach {$_ -replace 'anosu5', '!anosu5!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'anotu1') {(Get-Content $_ | ForEach {$_ -replace 'anotu1', '!anotu1!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'anotu2') {(Get-Content $_ | ForEach {$_ -replace 'anotu2', '!anotu2!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'anotu3') {(Get-Content $_ | ForEach {$_ -replace 'anotu3', '!anotu3!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'anotu4') {(Get-Content $_ | ForEach {$_ -replace 'anotu4', '!anotu4!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'anotu5') {(Get-Content $_ | ForEach {$_ -replace 'anotu5', '!anotu5!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'anofu1') {(Get-Content $_ | ForEach {$_ -replace 'anofu1', '!anofu1!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'anofu2') {(Get-Content $_ | ForEach {$_ -replace 'anofu2', '!anofu2!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'anofu3') {(Get-Content $_ | ForEach {$_ -replace 'anofu3', '!anofu3!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'anofu4') {(Get-Content $_ | ForEach {$_ -replace 'anofu4', '!anofu4!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'anofu5') {(Get-Content $_ | ForEach {$_ -replace 'anofu5', '!anofu5!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'appdur1') {(Get-Content $_ | ForEach {$_ -replace 'appdur1', '!appdur1!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'appdur2') {(Get-Content $_ | ForEach {$_ -replace 'appdur2', '!appdur2!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'appdur3') {(Get-Content $_ | ForEach {$_ -replace 'appdur3', '!appdur3!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'appdur4') {(Get-Content $_ | ForEach {$_ -replace 'appdur4', '!appdur4!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'appdur5') {(Get-Content $_ | ForEach {$_ -replace 'appdur5', '!appdur5!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'apperr1') {(Get-Content $_ | ForEach {$_ -replace 'apperr1', '!apperr1!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'apperr2') {(Get-Content $_ | ForEach {$_ -replace 'apperr2', '!apperr2!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'apperr3') {(Get-Content $_ | ForEach {$_ -replace 'apperr3', '!apperr3!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'apperr4') {(Get-Content $_ | ForEach {$_ -replace 'apperr4', '!apperr4!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'apperr5') {(Get-Content $_ | ForEach {$_ -replace 'apperr5', '!apperr5!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.

REM Replace Funnel forecast data
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'funconv1') {(Get-Content $_ | ForEach {$_ -replace 'funconv1', '!funconv1!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'funconv2') {(Get-Content $_ | ForEach {$_ -replace 'funconv2', '!funconv2!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'funconv3') {(Get-Content $_ | ForEach {$_ -replace 'funconv3', '!funconv3!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'funconv4') {(Get-Content $_ | ForEach {$_ -replace 'funconv4', '!funconv4!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'funconv5') {(Get-Content $_ | ForEach {$_ -replace 'funconv5', '!funconv5!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'funaban1') {(Get-Content $_ | ForEach {$_ -replace 'funaban1', '!funaban1!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'funaban2') {(Get-Content $_ | ForEach {$_ -replace 'funaban2', '!funaban2!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'funaban3') {(Get-Content $_ | ForEach {$_ -replace 'funaban3', '!funaban3!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'funaban4') {(Get-Content $_ | ForEach {$_ -replace 'funaban4', '!funaban4!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'funaban5') {(Get-Content $_ | ForEach {$_ -replace 'funaban5', '!funaban5!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'funvisit1') {(Get-Content $_ | ForEach {$_ -replace 'funvisit1', '!funvisit1!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'funvisit2') {(Get-Content $_ | ForEach {$_ -replace 'funvisit2', '!funvisit2!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'funvisit3') {(Get-Content $_ | ForEach {$_ -replace 'funvisit3', '!funvisit3!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'funvisit4') {(Get-Content $_ | ForEach {$_ -replace 'funvisit4', '!funvisit4!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'funvisit5') {(Get-Content $_ | ForEach {$_ -replace 'funvisit5', '!funvisit5!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'fnosu1') {(Get-Content $_ | ForEach {$_ -replace 'fnosu1', '!fnosu1!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'fnosu2') {(Get-Content $_ | ForEach {$_ -replace 'fnosu2', '!fnosu2!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'fnosu3') {(Get-Content $_ | ForEach {$_ -replace 'fnosu3', '!fnosu3!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'fnosu4') {(Get-Content $_ | ForEach {$_ -replace 'fnosu4', '!fnosu4!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'fnosu5') {(Get-Content $_ | ForEach {$_ -replace 'fnosu5', '!fnosu5!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'fundur1') {(Get-Content $_ | ForEach {$_ -replace 'fundur1', '!fundur1!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'fundur2') {(Get-Content $_ | ForEach {$_ -replace 'fundur2', '!fundur2!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'fundur3') {(Get-Content $_ | ForEach {$_ -replace 'fundur3', '!fundur3!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'fundur4') {(Get-Content $_ | ForEach {$_ -replace 'fundur4', '!fundur4!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
powershell -Command "Get-ChildItem -Path ./Transform\*ForecastAnalysis.json -recurse | ForEach {If (Get-Content $_.FullName | Select-String -Pattern 'fundur5') {(Get-Content $_ | ForEach {$_ -replace 'fundur5', '!fundur5!'}) | Set-Content $_ -encoding UTF8}}"
echo | set /p=.
echo .

REM Upload Forecasting Dashboards
curl -X PUT "https://!tenant!/api/config/v1/dashboards/18e35e26-8734-467e-9c04-0f398e0da%dashboardkey%" -H "accept: application/json; charset=utf-8" -H "Authorization: Api-Token %1" -H "Content-Type: application/json; charset=utf-8" -d @./Transform\RevenueForecastAnalysis.json
curl -X PUT "https://!tenant!/api/config/v1/dashboards/18e35e26-8734-467e-9c04-0f398e1da%dashboardkey%" -H "accept: application/json; charset=utf-8" -H "Authorization: Api-Token %1" -H "Content-Type: application/json; charset=utf-8" -d @./Transform\ApplicationForecastAnalysis.json
curl -X PUT "https://!tenant!/api/config/v1/dashboards/18e35e26-8734-467e-9c04-0f398e2da%dashboardkey%" -H "accept: application/json; charset=utf-8" -H "Authorization: Api-Token %1" -H "Content-Type: application/json; charset=utf-8" -d @./Transform\FunnelForecastAnalysis.json
 

