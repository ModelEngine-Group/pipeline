@echo off

:INPUT_VERSION
set /p PRE_VERSION=Please enter previous version (for example: v1.2.3):
if "%PRE_VERSION%"=="" (
    echo Error: Version cannot be empty. Please try again.
    echo.
    goto INPUT_VERSION
)

echo %PRE_VERSION% | findstr "v" >nul
if errorlevel 1 (
    echo Error: Version must contain 'v'
    goto INPUT_VERSION
) else (
    echo Version contains 'v'
)

echo === Upgrading... ===

if not exist "appengine\app-builder" (
    mkdir appengine\app-builder
    echo Directory appengine\app-builder created.
) else (
    echo Directory appengine\app-builder already exists.
)

if not exist "appengine\fit-runtime" (
    mkdir appengine\fit-runtime
    echo Directory appengine\fit-runtime created.
) else (
    echo Directory appengine\fit-runtime already exists.
)

if not exist "appengine\jade-db" (
    mkdir appengine\jade-db
    echo Directory appengine\jade-db created.
) else (
    echo Directory appengine\jade-db already exists.
)

if not exist "appengine\log" (
    mkdir appengine\log
    echo Directory appengine\log created.
) else (
    echo Directory appengine\log already exists.
)

echo Starting service
set IS_UPGRADE=true
docker-compose up -d
echo Service started

echo === Finished ===
pause