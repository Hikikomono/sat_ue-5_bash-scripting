#!/bin/bash

#Created by Hikikomono
#backup.sh backs up my ~/scripts directory and saves it in /tmp
#it creates a compressed tarball and filters? it using gzip
#my /home dir was way too big - so I backup ~/scripts dir



user=$USER
date_=$(date +"%Y-%m-%d_%H:%M:%S")

source_dir=~/scripts
destination_dir=/tmp/scripts_${user}_${date_}.tar.gz

tar -czf $destination_dir $source_dir 2> /dev/null

echo Successfull Backup of: $source_dir



