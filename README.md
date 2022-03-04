# AVKiller
AVKiller is a free open source tool with the goal of using basic ciphering to deliver powershell payloads without tripping static detection. 

AVKiller works by generating a key value between 0..50000, it is intended for base64 powershell scripts. It takes a payload 
as input. coverts to base64 and ciphers it using the key. 

Ciphering is very basic, similar to ROT-13, but it work.
Find your own amsi bypass at https://AMSI.fail (make sure it works by testing it first ;) that helps me often)
