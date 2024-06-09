@echo off

:: Root directory
set ROOT_DIR=lib

:: Create root directory
mkdir %ROOT_DIR%

:: Create subdirectories under lib
mkdir %ROOT_DIR%\app
mkdir %ROOT_DIR%\app\entrypoint
mkdir %ROOT_DIR%\app\theme

mkdir %ROOT_DIR%\presentation
mkdir %ROOT_DIR%\presentation\features
mkdir %ROOT_DIR%\presentation\widgets
mkdir %ROOT_DIR%\presentation\models
mkdir %ROOT_DIR%\presentation\utils

mkdir %ROOT_DIR%\domain
mkdir %ROOT_DIR%\domain\source
mkdir %ROOT_DIR%\domain\source\remote
mkdir %ROOT_DIR%\domain\source\local
mkdir %ROOT_DIR%\domain\di
mkdir %ROOT_DIR%\domain\models
mkdir %ROOT_DIR%\domain\utils

mkdir %ROOT_DIR%\data
mkdir %ROOT_DIR%\data\di
mkdir %ROOT_DIR%\data\repo_impls
mkdir %ROOT_DIR%\data\utils

echo Folder structure created successfully!
pause
