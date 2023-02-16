# DisTRaC Quickstart

This document covers quickly setting up and running DisTRaC on a single node with the Ubuntu OS. It expects the tester to have more than 8GB of RAM available for testing.

***A docker image is not made available as this program dynamically loads kernel modules, which is not possible in docker as far as I am aware.***

<!-- vscode-markdown-toc -->
* 1. [Bare metal](#Baremetal)
	* 1.1. [Installing packages](#Installingpackages)
	* 1.2. [Setup and configuration](#Setupandconfiguration)
	* 1.3. [Uninstalling packages](#Uninstallingpackages)
	* 1.4. [Removing DisTRaC](#RemovingDisTRaC)
	* 1.5. [End](#End)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->
##  1. <a name='Baremetal'></a>Bare metal
This section describes how to set up DisTRaC on a bare metal system.

###  1.1. <a name='Installingpackages'></a>Installing packages 

Please install the following applications. 

```
sudo apt-get install ceph lvm2 openmpi-bin bc
```

###  1.2. <a name='Setupandconfiguration'></a>Setup and configuration
This is all of the commands read through to understand each line.
```
git clone https://github.com/rosalindfranklininstitute/DisTRaC.git
cd DisTRaC
sudo groupadd -g 2000 distrac
sudo usermod -a -G distrac ${USER}
sudo cp sudoers_file/distrac /etc/sudoers.d/.
sudo cp distrac/*.sh /usr/bin/.
```

git clone this repo 

```
git clone https://github.com/rosalindfranklininstitute/DisTRaC.git
```

Change your directory to DisTRaC. 

```
cd DisTRaC
```

Create DisTRaC group 

```
sudo groupadd -g 2000 distrac
```

Add the user to the group.

```
sudo usermod -a -G distrac $USER
```

Copy the sudoers file to /etc/sudoers.d/

```
sudo cp sudoers_file/distrac /etc/sudoers.d/.
```

Copy DisTRaC source files to /usr/bin so the program can be run from anywhere.

```
sudo cp distrac/*.sh /usr/bin/.
```

###  1.3. <a name='Uninstallingpackages'></a>Uninstalling packages

This is all of the commands read through to understand each line.
```
sudo apt-get install ceph lvm2 openmpi-bin bc
sudo apt autoremove
```

Please remove the following applications. 

```
sudo apt-get install ceph lvm2 openmpi-bin bc
```

This leaves behind many packages that will no longer be required as they were installed as dependencies of this package. Therefore to easily remove these packages, please run.

```
sudo apt autoremove
```

###  1.4. <a name='RemovingDisTRaC'></a>Removing DisTRaC
This is all of the commands read through to understand each line.
```
sudo rm /etc/sudoers.d/distrac
sudo rm /usr/bin/calculate-pool-pg.sh /usr/bin/create-gram.sh /usr/bin/create-osd.sh /usr/bin/create-zram-lvm.sh /usr/bin/helpmsg.sh /usr/bin/remove-distrac.sh /usr/bin/remove-osd.sh /usr/bin/uge-hostfile.sh /usr/bin/create-brd.sh /usr/bin/create-mds.sh /usr/bin/create-pool.sh /usr/bin/create-zram.sh /usr/bin/process-hostfile.sh /usr/bin/remove-fs.sh /usr/bin/remove-temp-files.sh /usr/bin/create-fs.sh /usr/bin/create-mgr.sh /usr/bin/create-rgw.sh /usr/bin/distrac-config-log.sh /usr/bin/remove-brd.sh /usr/bin/remove-gram-lvm.sh /usr/bin/remove-zram-lvm.sh /usr/bin/create-gram-lvm.sh /usr/bin/create-mon.sh /usr/bin/create-s3-user.sh /usr/bin/distrac.sh /usr/bin/remove-ceph.sh /usr/bin/remove-gram.sh /usr/bin/remove-zram.sh
sudo gpasswd -d ${USER} distrac
sudo groupdel distrac
cd ..
rm -rf DisTraC
```
Remove the DisTRaC sudoers file
```
sudo rm /etc/sudoers.d/distrac
```
Remove the DisTraC files
```
sudo rm /usr/bin/calculate-pool-pg.sh /usr/bin/create-gram.sh /usr/bin/create-osd.sh /usr/bin/create-zram-lvm.sh /usr/bin/helpmsg.sh /usr/bin/remove-distrac.sh /usr/bin/remove-osd.sh /usr/bin/uge-hostfile.sh /usr/bin/create-brd.sh /usr/bin/create-mds.sh /usr/bin/create-pool.sh /usr/bin/create-zram.sh /usr/bin/process-hostfile.sh /usr/bin/remove-fs.sh /usr/bin/remove-temp-files.sh /usr/bin/create-fs.sh /usr/bin/create-mgr.sh /usr/bin/create-rgw.sh /usr/bin/distrac-config-log.sh /usr/bin/remove-brd.sh /usr/bin/remove-gram-lvm.sh /usr/bin/remove-zram-lvm.sh /usr/bin/create-gram-lvm.sh /usr/bin/create-mon.sh /usr/bin/create-s3-user.sh /usr/bin/distrac.sh /usr/bin/remove-ceph.sh /usr/bin/remove-gram.sh /usr/bin/remove-zram.sh
```

Delete the group and user
```
sudo gpasswd -d ${USER} distrac
sudo groupdel distrac
```
Delete the repo
```
cd ..
rm -rf DisTraC
```

###  1.5. <a name='End'></a>End

Thank you for following the quick start guide. If you have any questions feel free to raise an issue on the repo.
