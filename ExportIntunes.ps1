<#
 * Export intunes
#>
Install-Module AzureAD
Import-Module AzureAD
Connect-AzureAD

$users = Get-AzureADUser -All $true #Récupération de toutes les informations utilisateurs

foreach ($user in $users) {
    $uOID = $user.ObjectID	
    $utilisateur = $user.UserPrincipalName

    $periph = (Get-AzureADUserRegisteredDevice -ObjectId $uOID) #Récupéartion de tous les périphériques par Unique ObjectID utilisateur ($uOID)
    $periph_device_OS = $periph.DeviceOSType #Type d'OS
    $periph_device_OSVersion = $periph.DeviceOSVersion #Version OS 
    $periph_device_DisplayName = $periph.DisplayName #Nom du du périphérique 
    $periph_device_timestampLogin = $periph.ApproximateLastLogonTimeStamp #Dernière connexion à l'appareil
    $periph_device_count = $periph.count

    $colonne = New-Object -Type PSObject -Property @{
        'Nombre' = $periph_device_count  -join "***"
        'Utilisateur' = $utilisateur
        'Nom du peripherique' = $periph_device_DisplayName -join "***"
        'OS' = $periph_device_OS  -join "***"
        'Version OS' = $periph_device_OSVersion  -join "***"
        'Derniere connexion' = $periph_device_timestampLogin  -join "***"
    }

    $colonne | Export-CSV -path c:\Powershell\atest.csv -Append -NoTypeInformation -Force
    
}