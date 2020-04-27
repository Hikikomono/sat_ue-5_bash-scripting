#!/bin/bash

#Created by Hikikomono
#backup.sh backs up iy ~/scripts directory and saves it in /tmp
#it creates a compressed tarball and filters? it using gzip
#my /home dir was way too big - so I backup ~/scripts dir


#function to count files in current directory
nrFiles () {
	echo $(ls | wc -l)	
}

#function to count amnt of directories in current directory
nrDirectories () {
	 echo $(ls -d | wc -l)
	#bug -> printing name of prev func (nrFiles) wtf? -> old vers.
}

user=$USER
date_=$(date +"%Y-%m-%d_%H:%M:%S")

source_dir=~/scripts
destination_dir=/tmp/scripts_${user}_${date_}.tar.gz

let amt_files_before=$(nrFiles)

tar -czf $destination_dir $source_dir 2> /dev/null

let amt_files_after=$(nrFiles)


if ((amt_files_before==amt_files_after)) 
then
	echo Successfull Backup of: $source_dir
else 
	echo An Error occured while performing the Backup
fi

