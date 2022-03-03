# AVKiller
AVKiller is a free open source tool with the goal of using basic ciphering to deliver powershell payloads without tripping static detection. 

AVKiller works by generating a key value between 0..50000, it is intended for base64 powershell scripts. It takes a payload 
as input. coverts to base64 and ciphers it using the key. 

More advanced versions with key registry persistence will exist in the future.

To use it, run the payload generation script, input the payload and it will generate a payload and save to your clipboard. Paste it in the payload spot in the quotations
paste the integer key in the key spot
Generate an AMSI bypass from https://amsi.fail/ and put it in the AMSI payload slot. 

THIS IS A BETA VERSION FOR PROOF OF CONCEPT!!!!!!!

It is difficult to use succesfully. A version that automatically crypts a script from a file, then adds it to a payload with random chars and 
an AMSI bypass from https://amsi.fail/ is in the works and will exist in the future so please stay posted!!!

Note: This encryption is extremely basic. It does work though. The point is to be as simple as possible so that different types of loops could be used, avoiding the chance for microsoft to create a simple signature or to detect encryption. I will however release a module that uses AES128, for some peoples personal preferences.
