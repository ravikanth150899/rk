#!/bin/bash
cat<< EOF| fdisk dev/sdb
n
p
1

+100M
n
p
2

+100M
t
2
82
n
p
3

+100M
t
3
8e
w
EOF
echo 'y' |mkfs.ext4 dev/sdb1
mkdir /kernel1
echo "/dev/sdb1 /kernel1 ext4 defaults 0 0" >> /etc/fstab
mount /dev/sdb1 /kernel1
mkswap /dev/sdb2
swapon /dev/sdb2
echo "/dev/sdb2  swap   swap  defaults  0  0">> /etc/fstab
pvcreate /dev/sdb3
vgcreate ktvg3 /dev/sdb3
lvcreate -L 10M -n ktlv3 ktvg3
mkfs.ext4 /dev/ktvg3/ktlv3
mkdir ktdir3
echo "/dev/ktvg3/ktlv3 	/ktdir3	ext4	defaults	0	0">> /etc/fstab
mount /dev/ktvg3/ktlv3 /ktdir3
fdisk dev/sdb -l

