#!/bin/bash

#Created by Roberto En.
#backup.sh backs up iy ~/scripts directory and saves it in /tmp
#it creates a compressed tarball and filters? it using gzip
#my /home dir was way too big - so I backup ~/scripts dir


#function to count files in current directory (recursively)
nrFiles () {
	cd /home/${user}
	echo $(find -type f | wc -l)
}

#function to count amnt of directories in current directory (recursively)
nrDirectories () {
	cd /home/${user}
	echo $(find -type d | wc -l)
}

#function to count amt of files in tar archieve (recursively)
nrFilesInArchieve () {
	echo $(tar -tf ${destination_dir} | grep -v "/$" | wc -l)
}

#function to gen rnd pass & encrypt file
encryptFun () {
	#gen keypair
	cd /tmp/
	openssl genrsa -out private.key 1024
	openssl rsa -in private.key -pubout -out public.key
	#pass=1337 #just as an example..

	#sym encryption w/ pub key (could have gen. a random string with openssl)
	openssl enc -aes-256-cbc -pbkdf2 -salt -pass file:public.key -in ${destination_dir} -out ${destination_dir}.dec -base64
	echo ".. File encrypted .."

	#signing
	openssl dgst -sha256 -sign private.key -out signature.txt ${destination_dir}.dec
	echo ".. Signature created .."
}

file_count=0
directory_count=0
user_count=0
decision='y'

while [ $decision = 'y' ]
do
	#Check if USER dir exists
	read -p "Which Users home directory should be backed up?: " user
	if [ -z "$user" ]
	then
		user=$USER
		echo Empty input - backup default /home/${user}
	elif [ ! -d "/home/${user}/" ]
	then
		echo Directory does not exist - backup default /home/${USER}
		user=$USER
	else
		echo Directory for user ${user} will be backed up ...
	fi

	date_=$(date +"%Y-%m-%d_%H:%M:%S")
	source_dir=/home/${user}
	destination_dir=/tmp/scripts_${user}_${date_}.tar.gz

	#perform Backup & save amt of files before & after backup for SanityCheck
	amt_files_before=$(nrFiles)
	tar -czf $destination_dir $source_dir 2> /dev/null
	amt_files_after=$(nrFilesInArchieve)

	echo "Files in Folder to BackUp: ${amt_files_before}"
	echo "Files in BackUp folder (tar.gz): ${amt_files_after}"

	encryptFun

	#Sanity Check regarding amt of files
	if ((amt_files_before == amt_files_after)) 
	then
		echo Successfull Backup of: $source_dir
	else 
		echo An Error occured while performing the Backup
		echo Amount of Files in Backup and /home/${user} not euqal!
	fi

	#update counter variables
	let user_count++
	let file_count=$file_count+$(nrFiles)
	let directory_count=$directory_count+$(nrDirectories)
	
	rm $destination_dir #aus "zeitmangel" so gelöst =/

	echo "Backed-up: Users: ${user_count}  | Files: ${file_count}  | Dirs: ${directory_count}"
	echo ""
	read -p "Backup another /home/user/ directory? (y/n):" decision
	echo	""￼
done
