function Get-Enabled {
	$user = Read-Host "Введите имя пользователя"
	Get-ADUser -Identity $user -Properties Enabled, DisplayName | format-table @{Label='Логин'; Expression= {$_.samaccountName}}, @{Label='ФИО'; Expression= {$_.displayName}}, @{Label='Включен'; Expression = {$_.Enabled}}
	#Get-ADUser -Identity $user -Properties Enabled, DisplayName | Select-Object samaccountName, displayName, Enabled | format-table @{Label='Логин'; Expression= {$_.samaccountName}}, @{Label='ФИО'; Expression= {$_.displayName}}, @{Label='Включен'; Expression = {$_.Enabled}}
}

function Get-Guide {
	Write-Host "Всё просто."
	Write-Host "Для получения статуса учётной записи в домене, нужно в меню нажать 1."
	Write-Host "После этого ввести логин пользователя, которого нужно проверить."
	Write-Host "Скрипт покажет статус этой учётки. Если под полем Включен написано True - через эту учётку можно зайти в домен"
	Write-Host "Если же написано False - то она отключена и зайти с её помощью не получится."
}

function Get-Enabled-All {
	Get-ADUser -Filter {Enabled -eq "False"} | format-table @{Label='Логин'; Expression= {$_.samaccountName}}, @{Label='ФИО'; Expression= {$_.Name}}, @{Label='Включен'; Expression = {$_.Enabled}}
}

:menuLoop while ($true) {
    Write-Host "=====" -noNewline
	Write-Host "Меню" -foregroundcolor red -backgroundcolor yellow -noNewline
	Write-Host "====="
	Write-Host "1) " -noNewline
	Write-Host "Узнать статус учетной записи" -foregroundcolor yellow
	Write-Host "2) " -noNewline
	Write-Host "Показать все отключенные учётки" -foregroundcolor yellow
	Write-Host "3) " -noNewline
	Write-Host "Вывести справку" -foregroundcolor yellow
	Write-Host "8) " -noNewline
	Write-Host "Выйти" -foregroundcolor yellow

    switch (Read-Host "`nВыберите пункт меню") {
        '1' {Get-Enabled}
        '2' {Get-Enabled-All}
		'3' {Get-Guide}
        '8' {break menuLoop}
    }
}