#!/usr/bin/env bash
size=""
amount=0
folder="."
for i in "$@"
do
case $i in
    -s=*|--size=*)
    size="${i#*=}"
    shift # past argument=value
    ;;
    -n=*|--number=*)
    amount="${i#*=}"
    shift # past argument=value
    ;;
    -f=*|--folder=*)
    folder="${i#*=}"
    mkdir $folder 2> /dev/null
    shift # past argument=value
    ;;
    *)
          # unknown option
    ;;
esac
done
# This ignores root squash
cp gram.ko /tmp/
# Changes LVM so pvcreate can be used
create-gram-lvm.sh
sudo insmod  /tmp/gram.ko num_devices=$amount &
wait
for num in $(seq 0 $[amount-1])
do
	echo $size | sudo tee /sys/block/gram$num/disksize &
	wait
done

