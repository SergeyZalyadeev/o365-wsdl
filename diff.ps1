$sb = {
    $path = $args[0]
    $filename = $args[1]

    Add-Type -Path "$path\$filename.cs" -ReferencedAssemblies System,System.Web.Services,System.Xml
    $x = new-object ProvisioningWebService
    
    $x|gm
}

$j1 = Start-Job $sb -ArgumentList $pwd,old
$j2 = Start-Job $sb -ArgumentList $pwd,new

$old_defs = $j1 |Wait-Job | Receive-Job
$new_defs = $j2 |Wait-Job | Receive-Job

Compare-Object ($old_defs|%{$_.Name}) ($new_defs|%{$_.Name}) | Format-List
Compare-Object ($old_defs|%{$_.Definition}) ($new_defs|%{$_.Definition}) | Format-List
