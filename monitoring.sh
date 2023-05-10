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
	   
	   # Cmd for eval

| $ sudo adduser username                    | <- creating new user (yes (no)) |
| --- |

| | $ sudo chage -l username                   | <- Verify password expire info for new user |
| --- |

| | $ sudo adduser username sudo               | |
| --- |
|  |

| $ sudo adduser username user42             | <- assign new user to sudo and user42 groups

| 1) lsblk                              1 <- Check partitions |
| --- |

| | 2) sudo aa-status                     2 <- AppArmor status |
| --- |

| | 3) getent group sudo                  3 <- sudo group users |
| --- |

| | 4) getent group user42                4 <- user42 group users |
| --- |

| | 5) sudo service ssh status            5 <- ssh status, yep |
| --- |

| | 6) sudo ufw status                    6 <- ufw status |
| --- |

| | 7) ssh username@ipadress -p 4242      7 <- connect to VM from your host (physical) machine via SSH |
| --- |

| | 8) nano /etc/sudoers.d/<filename>     8 <- yes, sudo config file. You can $ ls /etc/sudoers.d first |
| --- |

| | 9) nano /etc/login.defs               9 <- password expire policy |
| --- |

| | 10) nano /etc/pam.d/common-password  10 <- password policy |
| --- |

| 11) sudo crontab -l                  11 <- cron schedule

| How to change hostname? |
| --- |

[$sudo nano /etc/hostname]

[$cd /var/log/sudo/00/00 && ls]

| [$ sudo apt update] |
| --- |

| [$ ls] |
| --- |

| Now you see that we have a new directory here. |
| --- |

| [$ cd <nameofnewdirectory> && ls] |
| --- |

| [$ cat log] <- Input log |
| --- |

[$ cat ttyout] <- Output log

| $ sudo ufw allow 8080] <- allow |
| --- |

| [$ sudo ufw status] <- check |
| --- |

[$ sudo ufw deny 8080] <- deny (yes yes)

| How to run script every 30 seconds? |
| --- |

[$ sudo crontab -e]

| */1 * * * * /path/to/monitoring.sh              | |
| --- |

| | */1 * * * * sleep 30s && /path/to/monitoring.sh | |
| --- |

| To stop script running on boot you just need to remove or commit |
| --- |

| @reboot /path/to/monitoring.sh |
