@echo off
echo === Deploying... ===

echo Loading app-builder
docker load -i app-builder-opensource-1.0.0.tar

echo Loading runtime-java
docker load -i fit-runtime-java-opensource-1.0.0.tar

echo Loading runtime-python
docker load -i fit-runtime-python-opensource-1.0.0.tar

echo Loading web
docker load -i jade-web-opensource-1.0.0.tar

echo Loading jade-db
docker load -i postgres.x86_64-15.2.tar

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