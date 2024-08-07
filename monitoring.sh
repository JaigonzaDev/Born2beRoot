#! /bin/bash
#The architecture of the operating system.
ARCH=$(uname -m)
#Kernel version
KERNEL=$(uname -r)
#Physical cores
CPU_PHYSICAL=$(lscpu | grep "Socket(s):" | awk '{print $2}')
#Virutal cores
CPU_VIRTUAL=$(lscpu | grep "^CPU(s):" | awk '{print $2}')
#The currently available RAM on your server and its usage percentage
RAM=$(free --mega | grep )
#The currently available memory on your server and its usage as a percentage.
MEM=
#The current usage percentage of your cores.
CPU_LOAD=
#The date and time of the last reboot.
LAST_BOOT=$(who -b | awk '{print $3, $4}')
#Whether LVM is active or not.
LVM=$(if [ $(lsblk | grep "lvm" | wc -l) -gt 0 ]; then echo yes; else echo no; fi)
#The number of active connections.
TCP=$(ss -ta | grep ESTAB | wc -l)
#The number of server users.
USERS=$(users | wc -w)
#The IPv4 address of your server and its MAC (Media Access Control) address.
IP=$(hostname -I)
MAC=$(cat /sys/class/net/enp0s3/adress)
#The number of commands executed with sudo.
SUDO=$(journalctl _COMM=sudo | grep COMMAND | wc -l)
