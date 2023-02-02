# DisTRaC Quick Start

This document covers quickly setting up and running DisTRaC on a single node with the Ubuntu OS. It expects the tester to have more than 8GB of RAM available for testing.

<!-- vscode-markdown-toc -->
* 1. [Bare metal](#Baremetal)
	* 1.1. [Installing packages](#Installingpackages)
	* 1.2. [Setup and configuration](#Setupandconfiguration)
	* 1.3. [Running DisTRaC](#RunningDisTRaC)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->

##  1. <a name='Baremetal'></a>Bare metal
This section goes over how to set up DisTRaC on a bare metal system.

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

Change your directory to DisTRaC 

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

Copy sudoers file to /etc/sudoers.d/

```
sudo cp sudoers_file/distrac /etc/sudoers.d/.
```

Copy DisTRaC source files to /usr/bin so the program can be run from anywhere.

```
sudo cp distrac/*.sh /usr/bin/.
```

###  1.3. <a name='RunningDisTRaC'></a>Running DisTRaC

This is all of the commands read through to understand each line
```
mkdir testing
cd testing
hostname > hosts
distrac.sh -i=lo -s=8G -n=1 -t=ram -hf=hosts -pn=test
ceph -s 
rados bench -O 1M -p test 1 write
remove-distrac.sh -t=ram -hf=hosts
cd ..
rm -rf testing
```

Create a testing folder and move inside 
```
mkdir testing
cd testing
```

Create hostfile 

```
hostname > hosts
```

Run DisTRaC command 

```
distrac.sh -i=lo -s=1G -n=1 -t=ram -hf=hosts -pn=test
```

Check the status of ceph

```
ceph -s 
```
Run a benchmark to check that DisTRaC ran correctly.

```
rados bench -O 1M -p test 1 write
```
Remove DisTRaC 
```
remove-distrac.sh -t=ram -hf=hosts
```

Remove testing folder
```
cd ..
rm -rf testing
```
