# 1. Получаем путь к папке VirtualBox VMs текущего пользователя
$vmPath = "$env:USERPROFILE\VirtualBox VMs"

if (!(Test-Path $vmPath)) {
    Write-Host "Папка VirtualBox VMs не найдена: $vmPath"
    exit
}

# 2. Получаем список папок (виртуальных машин)
$vms = Get-ChildItem -Path $vmPath -Directory | Select-Object -ExpandProperty Name

if ($vms.Count -eq 0) {
    Write-Host "Виртуальные машины не найдены."
    exit
}

# 3. Выбор через стрелки
Write-Host "Выберите виртуальную машину стрелками и нажмите Enter:`n"
$selected = $vms | Out-GridView -Title "Выбор VM" -PassThru

if (!$selected) {
    Write-Host "Выбор отменён."
    exit
}

# 4. Переход в директорию VirtualBox
Set-Location "C:\Program Files\Oracle\VirtualBox"

# 5. Выполнение команды
Write-Host "`nВключаю nested virtualization для: $selected`n"
.\VBoxManage.exe modifyvm "$selected" --nested-hw-virt on

Write-Host "`nГотово."
Pause0 sdd
