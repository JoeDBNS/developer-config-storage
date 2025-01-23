$accounts = @(
    "davisj38"
)

$datetime_now = Get-Date

Write-Host ""

Write-Host "Days`tTimestamp`t`tAccount"

Foreach ($account in $accounts) {
    try {
        $timestamp_account_last_logon = Get-ADUser $account -Properties lastLogon | Select-Object -ExpandProperty lastLogon
        $datetime_account_last_logon = [DateTime]::FromFileTimeUtc($timestamp_account_last_logon)

        $timespan_compare = New-TimeSpan -Start $datetime_now -End $datetime_account_last_logon
        $days_compare = $timespan_compare.Days
        $text_color = "Green"

        if (($days_compare + 90) -lt 30) {
            $text_color = "Red"
        }

        Write-Host ("" + ($days_compare + 90) + "`t" + $datetime_account_last_logon + "`t" + $account) -ForegroundColor $text_color
    }
    catch {
        # Service Accounts don't have lastLogon but LastlogonTimestamp accuracy is going to rely on the AD Servers and Domain Controllers being in sync.
        try {
            $timestamp_account_last_logon = Get-ADUser $account -Properties LastlogonTimestamp | Select-Object -ExpandProperty LastlogonTimestamp
            $datetime_account_last_logon = [DateTime]::FromFileTimeUtc($timestamp_account_last_logon)

            $timespan_compare = New-TimeSpan -Start $datetime_now -End $datetime_account_last_logon
            $days_compare = $timespan_compare.Days
            $text_color = "Green"

            if (($days_compare + 90) -lt 30) {
                $text_color = "Red"
            }

            Write-Host ("" + ($days_compare + 90) + "`t" + $datetime_account_last_logon + "*`t" + $account) -ForegroundColor $text_color
        }
        catch {
            Write-Host ("00`tERROR`t`t`t" + $account) -ForegroundColor "Red"
        }
    }

}

Write-Host ""
