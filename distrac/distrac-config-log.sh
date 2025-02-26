#!/usr/bin/env bash
folder="."
for i in "$@"
do
case $i in
    -f=*|--folder=*)
    folder="${i#*=}"
    mkdir $folder
    shift # past argument=value
    ;;
    *)
          # unknown option
    ;;
esac
done

echo "
#Log to /dev/null
log flush on exit = false
log file = /dev/null 
mon cluster log file = /dev/null
#Log level 0 and memory 0
debug default = 0/0
debug lockdep = 0/0
debug context = 0/0 
debug crush = 0/0 
debug mds = 0/0 
debug mds balancer = 0/0 
debug mds locker = 0/0 
debug mds log = 0/0 
debug mds log expire = 0/0 
debug mds migrator = 0/0 
debug buffer = 0/0 
debug timer = 0/0 
debug filer = 0/0 
debug striper = 0/0 
debug objecter = 0/0
debug rados = 0/0  
debug rbd = 0/0 
debug rbd mirror = 0/0 
debug rbd replay = 0/0 
debug journaler = 0/0 
debug objectcacher = 0/0
debug client = 0/0
debug osd = 0/0
debug optracker = 0/0
debug objclass = 0/0
debug filestore = 0/0
debug journal = 0/0
debug ms = 0/0
debug mon = 0/0
debug monc = 0/0
debug paxos = 0/0
debug tp = 0/0
debug auth = 0/0
debug crypto = 0/0
debug finisher = 0/0
debug reserver = 0/0
debug heartbeatmap = 0/0
debug perfcounter = 0/0
debug rgw = 0/0
debug rgw sync = 0/0
debug civetweb = 0/0
debug javaclient = 0/0
debug asok = 0/0
debug throttle = 0/0
debug refs = 0/0
debug compressor = 0/0
debug bluestore = 0/0
debug bluefs = 0/0
debug bdev = 0/0
debug kstore = 0/0
debug rocksdb = 0/0
debug leveldb = 0/0
debug memdb = 0/0
debug fuse = 0/0
debug mgr = 0/0
debug mgrc = 0/0
debug dpdk = 0/0
debug eventtrace = 0/0
" >> $folder/ceph.conf
