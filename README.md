# Проверка статуса Enabled в учётных записях домена
Это PS-скрипт для поиска всех активных и неактивных учёток в домене. Также можно посмотреть статус отдельной учётки.

## Подготовка
Перед запуском скрипта необходимо открыть Powershell от имени администратора и ввести следующие команды:
1. `Add-WindowsCapability -online -Name Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0`
2. `Get-WindowsCapability -Name RSAT.ActiveDirectory* -Online | Add-WindowsCapability -Online`

Этот скрипт нужно запускать от имени администратора. Для этого есть два варианта: из Powershell и из контекстного меню
### Powershell
Запустить powershell от админа, перейти в директорию с скриптом и запустить его.
### Через контекстное меню a.k.a. ПКМ
1. Запустите редактор реестра (regedit.exe)
2. Перейдите в ветку **HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1\shell**
3. Создайте подраздел с именем **runas** и перейдите в него
4. Внутри раздела runas создайте пустой строковый параметр (String Value) с именем **HasLUAShield** (этот параметр добавит иконку UAC в контекстное меню проводника)
5. В разделе runas создайте вложенный подраздел **command**
6. В качестве значения параметра Default раздела command укажите значение: `powershell.exe "-Command" "if((Get-ExecutionPolicy ) -ne 'AllSigned') { Set-ExecutionPolicy -Scope Process Bypass }; & '%1'"`

Теперь если кликнуть на .ps1 файл правой кнопкой, то появится пункт "Запустить от имени администратора"
