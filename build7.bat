@echo off
REM =====================================================================
REM  build7.bat - Dong goi web Restaurant7 de chay tren Tomcat 8.5
REM  Ket qua: thu muc target\restaurant7 (exploded) va target\restaurant7.war
REM  Chay trong Terminal cua VS Code:  .\build7.bat
REM =====================================================================
setlocal
cd /d "%~dp0"

set "JAR_NAME=mysql-connector-java-8.0.13.jar"
set "JAR_URL=https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.13/%JAR_NAME%"
set "LIB_DIR=src\main\webapp\WEB-INF\lib"
set "OUT=target\restaurant7"

REM ---- Tim javac/jar: uu tien JAVA_HOME, neu khong co thi dung PATH ----
set "JAVAC=javac"
set "JARTOOL=jar"
if defined JAVA_HOME (
  if exist "%JAVA_HOME%\bin\javac.exe" set "JAVAC=%JAVA_HOME%\bin\javac.exe"
  if exist "%JAVA_HOME%\bin\jar.exe" set "JARTOOL=%JAVA_HOME%\bin\jar.exe"
)
"%JAVAC%" -version >nul 2>&1
if errorlevel 1 (
  echo [LOI] Khong tim thay javac. Hay cai JDK va dat bien JAVA_HOME hoac them JDK\bin vao PATH.
  exit /b 1
)

REM ---- 1. Tai driver MySQL neu chua co ----
if not exist "%LIB_DIR%" mkdir "%LIB_DIR%"
if not exist "%LIB_DIR%\%JAR_NAME%" (
  echo [1/4] Dang tai %JAR_NAME% ...
  curl -L -s -o "%LIB_DIR%\%JAR_NAME%" "%JAR_URL%"
  if not exist "%LIB_DIR%\%JAR_NAME%" (
    echo [LOI] Khong tai duoc driver MySQL. Hay tai thu cong tu:
    echo        %JAR_URL%
    echo        roi chep vao %LIB_DIR%
    exit /b 1
  )
) else (
  echo [1/4] Da co %JAR_NAME%
)

REM ---- 2. Chep giao dien web vao target ----
echo [2/4] Chep thu muc webapp ...
if exist "%OUT%" rmdir /s /q "%OUT%"
xcopy /E /I /Y /Q "src\main\webapp" "%OUT%" >nul
if not exist "%OUT%\WEB-INF\classes" mkdir "%OUT%\WEB-INF\classes"

REM ---- 3. Bien dich model7 + dao7 (bytecode Java 8 de chay duoc tren Tomcat 8.5) ----
echo [3/4] Bien dich Java ...
set "RELEASE=--release 8"
"%JAVAC%" -version 2>&1 | findstr /C:" 1.8" >nul && set "RELEASE="
"%JAVAC%" %RELEASE% -nowarn -encoding UTF-8 -d "%OUT%\WEB-INF\classes" src\main\java\model7\*.java src\main\java\dao7\*.java
if errorlevel 1 (
  echo [LOI] Bien dich that bai.
  exit /b 1
)

REM ---- 4. Dong goi file war ----
echo [4/4] Dong goi target\restaurant7.war ...
if exist "target\restaurant7.war" del /q "target\restaurant7.war"
"%JARTOOL%" -cf "target\restaurant7.war" -C "%OUT%" . >nul 2>&1
if errorlevel 1 (
  echo [CANH BAO] Khong tao duoc file war ^(khong thay lenh jar^). Dung thu muc %OUT% de deploy.
) else (
  echo        Da tao target\restaurant7.war
)

echo.
echo XONG. Deploy target\restaurant7.war ^(hoac thu muc target\restaurant7^) len Tomcat,
echo roi mo http://localhost:8080/restaurant7/
endlocal
