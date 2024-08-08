#! /bin/bash
#The architecture of the operating system.
ARCH=$(uname -a)
#Physical cores
CPU_PHYSICAL=$(lscpu | grep "Socket(s):" | awk '{print $2}')
#Virtual cores
CPU_VIRTUAL=$(lscpu | grep "^CPU(s):" | awk '{print $2}')
#The currently available RAM on your server and its usage percentage
RAM_TOTAL=$(free --mega | awk '/Mem:/' | awk '{print $2}')
RAM_USED=$(free --mega | awk '/Mem:/' | awk '{print $3}')
RAM_PERCENT=$(echo "scale=2; ($RAM_USED/$RAM_TOTAL)*100" | bc)
#The currently available memory on your server and its usage as a percentage.
MEM_USED=$(df -h --total | awk '/total/' | awk '{print $3}')
MEM_TOTAL=$(df -h --total | awk '/total/' | awk '{print $2}')
MEM_PERCENT=$(df -h --total | awk '/total/' | awk '{print $5}')
#The current usage percentage of your cores.
CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | awk -F '[,]' '{print 100 - $4 "%"}')
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
MAC=$(cat /sys/class/net/enp0s3/address)
#The number of commands executed with sudo.
SUDO=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

wall "
#Architecture: $ARCH
#CPU physical: $CPU_PHYSICAL
#vCPU: $CPU_VIRTUAL
#Memory Usage: $RAM_USED / ${RAM_TOTAL}MB ($RAM_PERCENT%)
#Disk Usage: $MEM_TOTAL / $MEM_USED ($MEM_PERCENT)
#CPU load: $CPU_LOAD
#Last boot: $LAST_BOOT
#LVM use: $LVM
#TCP Connections: $TCP ESTABLISHED
#User log: $USERS
#Network: IP $IP ($MAC)
#Sudo: $SUDO cmd"
