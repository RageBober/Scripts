@echo off

net session >nul 2>&1 || (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

powershell -nop -ep bypass -c "irm https://get.activated.win | iex"