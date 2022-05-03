#!/usr/bin/env bash

sudo mkdir $HOME/mycephfs
sudo mount -t ceph :/ $HOME/mycephfs -o name=admin,secret=`ceph auth print-key client.admin`
sudo chown $USER:$USER $HOME/mycephfs
sudo chmod 777 $HOME/mycephfs
