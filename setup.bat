@echo off
@echo off

:: Установка кодировки UTF-8
chcp 65001 >nul

:: Указание версии программы
set VERSION=1.2.0
echo ============================================================
echo               Spotify Premium MOD Tool v%VERSION%
echo               Программа создана KDG
echo ============================================================
echo.

:: Проверка, запущен ли скрипт с правами администратора
:: Попытка создать временный файл в защищенной папке
fsutil dirty query %systemdrive% >nul 2>&1
if %errorlevel% neq 0 (
    :: Если не администратор, перезапуск с правами администратора
    echo Запуск от имени администратора...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: Основное меню
:main_menu
echo ============================================================
echo                Spotify Premium MOD Tool
echo               Программа создана KDG
echo ============================================================
echo.
echo Выберите действие:
echo [1] Установить Spotify Premium MOD
echo [2] Удалить Spotify (только модификации)
echo [3] Что такое Spotify Premium MOD от KDG?
echo [4] Удалить оригинальный Spotify
echo [0] Выйти
echo.

set /p choice="Введите номер действия и нажмите Enter: "

if "%choice%"=="1" goto install
if "%choice%"=="2" goto uninstall
if "%choice%"=="3" goto info
if "%choice%"=="4" goto remove_original
if "%choice%"=="0" goto exit

:: Если введено что-то неверное
echo Неверный выбор. Пожалуйста, перезапустите программу.
pause
goto exit

:install
echo ============================================================
echo              УСТАНОВКА SPOTIFY PREMIUM MOD
echo ============================================================
echo.

:: Проверка наличия оригинального Spotify и его удаление
echo Проверяем, установлен ли оригинальный Spotify...
if exist "%AppData%\Spotify" (
    echo Оригинальный Spotify найден, начинаем удаление...
    rmdir /s /q "%AppData%\Spotify"
    echo Оригинальный Spotify был удален.
) else (
    echo Оригинальный Spotify не найден.
)

:: Загрузка и запуск SpotX
echo Загружаем и устанавливаем модификацию Spotify...
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = 3072; Invoke-WebRequest -UseBasicParsing 'https://spotx-official.github.io/run.ps1' -OutFile '%~dp0run.ps1'}"
%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File "%~dp0run.ps1" -new_theme

echo ============================================================
echo Установка завершена. Наслаждайтесь Spotify Premium MOD!
echo ============================================================
pause
goto main_menu

:uninstall
echo ============================================================
echo              УДАЛЕНИЕ SPOTIFY (Только модификации)
echo ============================================================
echo.

:: Удаление модифицированных файлов
echo Удаляем модификации Spotify...
if exist "%AppData%\Spotify" (
    rmdir /s /q "%AppData%\Spotify"
    echo Модифицированные файлы Spotify удалены.
) else (
    echo Модификации SpotX не найдены.
)

echo ============================================================
echo Удаление завершено.
echo ============================================================
pause
goto main_menu

:info
echo ============================================================
echo               Что такое Spotify Premium MOD от KDG?
echo ============================================================
echo.
echo Spotify Premium MOD от KDG — это модификация официального клиента Spotify, 
echo которая позволяет пользователю получить доступ ко всем премиум функциям Spotify без 
echo необходимости подписки. Включает в себя:
echo - Прослушивание музыки без рекламы
echo - Пропуск песен без ограничений
echo - Качество звука на высшем уровне
echo - Доступ ко всем песням, альбомам и плейлистам без подписки
echo
echo Этот мод был создан для пользователей, которые хотят наслаждаться всеми премиум 
echo функциями, не тратя деньги на подписку.
echo
echo Программа была разработана KDG и предоставляется бесплатно для использования.
echo ============================================================
pause
goto main_menu

:remove_original
echo ============================================================
echo           УДАЛЕНИЕ ОРИГИНАЛЬНОГО SPOTIFY
echo ============================================================
echo.

:: Удаление оригинальной версии Spotify
echo Проверяем, установлен ли оригинальный Spotify...
if exist "%AppData%\Spotify" (
    echo Оригинальный Spotify найден, начинаем удаление...
    rmdir /s /q "%AppData%\Spotify"
    echo Оригинальный Spotify был удален.
) else (
    echo Оригинальный Spotify не найден.
)

echo ============================================================
echo Удаление оригинального Spotify завершено.
echo ============================================================
pause
goto main_menu

:exit
echo Завершение работы. Спасибо за использование программы!
pause
exit /b

