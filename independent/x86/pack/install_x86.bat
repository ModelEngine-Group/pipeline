@echo off
set "IMAGE_DIR=.\images"

echo === Deploying... ===

for %%i in ("%IMAGE_DIR%\*.tar") do (
    echo Loading %%~nxi
    docker load -i "%%i"
    echo.
)

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
docker-compose up -d
echo Service started

echo === Finished ===
pause