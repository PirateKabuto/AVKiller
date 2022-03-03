# AVKiller
AVKiller is a free open source tool with the goal of using basic ciphering to deliver powershell payloads without tripping static detection. 

AVKiller works by generating a key value between 0..50000, it is intended for base64 powershell scripts. It takes a payload 
as input. coverts to base64 and ciphers it using the key. 

More advanced versions with key registry persistence will exist in the future.

To use it, run the payload generation script, input the payload and it will generate a payload and save to your clipboard. Paste it in the payload spot in the quotations
paste the integer key in the key spot
Generate an AMSI bypass from https://amsi.fail/ and put it in the AMSI payload slot. 
