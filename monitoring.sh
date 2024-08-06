#! /bin/bash
ARCH=$(uname -m)
KERNEL=$(uname -r)
CPU_PHYSICAL=$(lscpu | grep "Socket(s):" | awk '{print $2}')
VCPU=$(lscpu | grep "^CPU(s):" | awk '{print $2}')
