function Get-Status {
	$user = Read-Host "Введите имя пользователя"
	Get-ADUser -Identity $user -Properties Enabled, DisplayName | format-table @{Label='Логин'; Expression= {$_.samaccountName}}, @{Label='ФИО'; Expression= {$_.displayName}}, @{Label='Включен'; Expression = {$_.Enabled}}
	Write-Host "`n"
}

function Get-Enabled-All {
	$result_en = Get-ADUser -Filter {Enabled -eq "True"} | Sort-Object Name | format-table @{Label='ФИО'; Expression= {$_.Name}}, @{Label='Логин'; Expression= {$_.samaccountName}}, @{Label='Отдел'; Expression={$_.DistinguishedName -replace '.+?,OU=(.+?),(?:OU|DC)=.+','$1'}}
	Write-Output $result_en
	Out-File -FilePath "c:\users\***\desktop\Все активные учётки.txt" -InputObject $result_en
	Write-Host "Выгрузка была сохранена на рабочем столе с именем Все активные учётки.txt" -foregroundcolor yellow
	Write-Host "`n"
}

function Get-Disabled-All {
	$result_dis = Get-ADUSer -Filter {Enabled -eq "False"} | Sort-Object Name | format-table @{Label='ФИО'; Expression={$_.Name}}, @{Label='Логин'; Expression={$_.SamAccountName}}, @{Label='Отдел'; Expression={$_.DistinguishedName -replace '.+?,OU=(.+?),(?:OU|DC)=.+','$1'}}
	Write-Output $result_dis
	Out-File -FilePath "c:\users\***\desktop\Все отключённые учётки.txt" -InputObject $result_dis
	Write-Host "Выгрузка была сохранена на рабочем столе с именем Все отключённые учётки.txt" -foregroundcolor yellow
	Write-Host "`n"
}

function Get-Guide {
	Write-Host "`n"	
	Write-Host "Всё просто."
	Write-Host "`n"	
	Write-Host "Для получения статуса учётной записи в домене, нужно в меню нажать 1."
	Write-Host "После этого ввести логин пользователя, которого нужно проверить."
	Write-Host "Скрипт покажет статус учётки. Если под полем Включен написано True - через эту учётку можно зайти в домен"
	Write-Host "Если же написано False - то она отключена и зайти с её помощью не получится."
	Write-Host "`n"
	Write-Host "Для получения списка всех активных учеток, нужно в меню нажать 2."
	Write-Host "Скрипт их покажет в окошке программы и сохранит список на рабочий стол."
	Write-Host "`n"	
	Write-Host "Для получения списка неактивных учёток, нажмите 3."
	Write-Host "Скрипт также их выведет на экран и сохранит в текстовом файле."
	Write-Host "`n"
	
}

:menuLoop while ($true) {
    Write-Host "=====" -noNewline
	Write-Host "Меню" -foregroundcolor red -backgroundcolor yellow -noNewline
	Write-Host "====="
	Write-Host "1) " -noNewline
	Write-Host "Узнать статус учетной записи" -foregroundcolor yellow
	Write-Host "2) " -noNewline
	Write-Host "Показать все активные учётки" -foregroundcolor yellow
	Write-Host "3) " -noNewline
	Write-Host "Показать все отключенные учётки" -foregroundcolor yellow
	Write-Host "4) " -noNewline
	Write-Host "Вывести справку" -foregroundcolor yellow
	Write-Host "8) " -noNewline
	Write-Host "Выйти" -foregroundcolor yellow

    switch (Read-Host "`nВыберите пункт меню") {
        '1' {Get-Status}
        '2' {Get-Enabled-All}
		'3' {Get-Disabled-All}
		'4' {Get-Guide}
        '8' {break menuLoop}
    }
}
