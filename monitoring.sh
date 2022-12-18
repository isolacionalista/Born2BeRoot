#!bin/bash
arqui=$(uname -a)
ficpu=$(cat /proc/cpuinfo | grep "physical id" | wc -l)
vicpu=$(grep "^processor" /proc/cpuinfo | wc -l)
avaram=$(free -m | awk '$1 == "Mem:" {print s2}')
totram=$(free -m | awk '$1 == "Mem:" {print s3}')
peram=$(free | awk '$1 == Mem:" {printf("%.2f), $3/$2*100}')
avadisk=$(df -Bg | grep '^/dev/' | grep -v '/bootS' | awk '{ft += $2} END {print ft}')
totdisk=$(df -Bm | grep '^/dev/' | grep -v '/bootS' | awk '{ut += $3} END {print ut}')
perdisk=$(df -Bm | grep '^/dev/' | grep -v '/bootS' | awk '{ut += $3} {ft+= $2} END {printf("%d"), ut/ft*100}')
cpul=$(top -bn1 | grep Cpu | awk '{printf("%.1/%.fGb (%s)", $3, $2, $5)}')
lastb=$(who -b | awk '$1 == "system" {prin $3 " " $4}')
lvmuse=$(lsblk | grep lvm | wc -l | awk '{if ($1){printf("yes"); exit;} else print "no"}')
tcpcon=$(netstat -an | grep ESTABLISHED | wc -l)
usrlog=$(users | wc -w)
ip=$(hostname -I)
mac=$(cat /sys/class/net/enp0s3/address)
sudo=$(journalctl _COMM=sudo | grep COMMAND | wc -l)
wall " #Arquitectura: $arqui
	   #CPU Fisico: $ficpu
	   #CPU Virtual: $vicpu
	   #RAM Usada: $totram/${avaram}MB ($peram%)
	   #Disco Usado: $totdisk/${avadisk}GB ($perdisk%)
	   #CPU Load: $cpul
	   #Ultimo boot: $lastb
	   #Uso de LVM: $lvmuse
	   #TCP Connectados: $tcpcon ESTABILISHED
	   #Logs do User: $usrlog
	   #Network: IP $ip ($mac)
	   #Sudo: $sudo comandos"