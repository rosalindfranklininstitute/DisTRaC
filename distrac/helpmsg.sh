#!/usr/bin/env bash

#Prints out a help message for users

function helpmsg(){	echo " 
 -i=  | --interface=  Network interface to use, i.e. -i=ib0 or --interface=ib0 (Required)
 -s=  | --size=       Size of RAM to use, i.e. -s=50GB or --size=100GB (Required)
 -n=  | --number=     Number of RAM OSDs on each host, if -s=50GB and -n=5 that will create 5 OSDs using 250GB of RAM (Required)
 -t=  | --type=       The type of RAM Block gram, ram (brd), zram i.e. -t=gram or -t=ram or --type=zram (Required) 
 -f=  | --folder=     Folder to locate Ceph keys this allows for multiple deployments when different folders speficed.
 -hf= | --hostfile=   When not using UGE with a parallel environment, provide a file with a list of comma separated hosts
 -pn= | --poolname=   Define the name of a pool if using RADOS, i.e. -pn=example or --poolname=example 
 -fs= | --filesystem= To use a cephfs specifiy a location that you want the system to mount i.e. -fs=/mnt/mycephfs
 -rgw | --rgw         To use a rados gateway set the flag set on i.e. -rgw or --rgw
 -uid=| --uid=        To create an s3 user for the rados gateway i.e.  -uid=test or --uid=test
 -sk= | --secretkey=  This will create an acess and secret key for the user define in -uid, i.e. -sk=test or --secretkey=test
 -h   | --help 	      Display help message
"
}

function helpmsgremove(){	echo "
 -f=  | --folder=     Folder with Ceph keys to remove
 -t=  | --type=       The type of RAM Block gram, ram (brd), zram i.e. -t=gram or -t=ram or --type=zram (Required) 
 -hf= | --hostfile=   When not using UGE with a parallel environment, provide a file with a list of comma separated hosts for Ceph removal.
 -fs= | --filesystem= To remove the filesystem specifiy the mount point used i.e. -fs=/mnt/mycephfs
 -h   | --help 	      Display help message
"
}
