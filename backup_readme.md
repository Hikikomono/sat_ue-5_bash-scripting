Author: Roberto Enko
Date: 27.04.2020

---Purpose of the Program---  
The script creates a Backup of the /home/{user} directory of a specific user as a tar.gz archieve.
The tar.gz archieve then gets encrypted (aes-256) and signed (sha-256).


---How is it used---  
Give the script execute rights using "chmod +x backup.sh"  
Start the script using "./welcome"  
The script will ask for a username to back up.  
If no Username is given, the home directory of the current user gets backed-up.  
After the backup a prompt appears, asking for another user directory to backup.  

---Example Output---  
Which Users home directory should be backed up?: testron  
Directory for user testron will be backed up ...  
Generating RSA private key, 1024 bit long modulus (2 primes)
........................................+++++
...............................................+++++
e is 65537 (0x010001)
writing RSA key  
.. File encrypted ..  
.. Signature created ..  
Successfull Backup of: /home/testron  
Backed-up: Users: 1  | Files: 3  | Dirs: 1  

Backup another directory? (y/n):

