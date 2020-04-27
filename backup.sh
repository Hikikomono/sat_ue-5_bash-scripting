#!/bin/bash

#Created by Hikikomono
#backup.sh backs up iy ~/scripts directory and saves it in /tmp
#it creates a compressed tarball and filters? it using gzip
#my /home dir was way too big - so I backup ~/scripts dir


#function to count files in current directory
nrFiles () {
	cd ~/scripts
	echo $(find -type f | wc -l)
 #echo $(ls | wc -l)	#not recursively
}

#function to count amnt of directories in current directory
nrDirectories () {
	cd ~/scripts 
	echo $(find -type d | wc -l)
	#bug -> printing name of prev func (nrFiles) wtf? -> old vers.
}

#function to count amt of files in tar archieve
nrFilesInArchieve () {
				echo $(tar -tf ${destination_dir} | grep -v "/$" | wc -l)
}

user=$USER
date_=$(date +"%Y-%m-%d_%H:%M:%S")

source_dir=~/scripts
destination_dir=/tmp/scripts_${user}_${date_}.tar.gz

amt_files_before=$(nrFiles)

tar -czf $destination_dir $source_dir 2> /dev/null


amt_files_after=$(nrFilesInArchieve)


echo "Files in Folder to BackUp: ${amt_files_before}"
echo "Files in BackUp folder (tar.gz): ${amt_files_after}"


if ((amt_files_before==amt_files_after)) 
then
	echo Successfull Backup of: $source_dir
else 
	echo An Error occured while performing the Backup
fi
