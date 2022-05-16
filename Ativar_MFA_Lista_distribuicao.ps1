#Ativar MFA para todos os usuários em uma lista de distribuição
#Caso algum membro da lista já tenha o MFA Cadastrado, a ativaçao não será realizada.

# Passar o endereço do grupo em $gruponame
$gruponame=Read-Host

$DGMembers=Get-DistributionGroupMember $gruponame


foreach($member in $DGMembers)
{

"$MFA_ENABLE"


$upn=Get-MsolUser -UserPrincipalName $member.PrimarySmtpAddress
If ($upn.StrongAuthenticationMethods.Count -eq 0) {$user = $upn.UserPrincipalName} else { $user = $null } 

"--------------------------------------------------"
"Usuario -> $user"
"--------------------------------------------------"

 $st = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
    $st.RelyingParty = "*"
    $st.State = "Enabled"
    $sta = @($st)
    Set-MsolUser -UserPrincipalName $user -StrongAuthenticationRequirements $sta

}