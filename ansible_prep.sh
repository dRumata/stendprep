#!/bin/bash
# Настройка стенда
# Дата: 11.01.2024

# Ввод значений переменных
echo -n "Суффикс для имен ВМ в виде imyafamilia: "
read suffix
echo -n "Адрес /24 подсети без последнего октета  [172.16.110]: "
read netaddr
netaddr=${netaddr:=172.16.110}

echo -n "IP адреc (только 4-й октет) сервера ws-$suffix.lab.example.com [100]: "
read wsip
wsip=${wsip:=100}

echo -n "IP адреc (только 4-й октет) сервера servera-$suffix.lab.example.com [101]: "
read s1ip
s1ip=${s1ip:=101}

echo -n "IP адреc (только 4-й октет) сервера serverb-$suffix.lab.example.com [102]: "
read s2ip
s2ip=${s2ip:=102}

echo -n "IP адреc (только 4-й октет) сервера serverc-$suffix.lab.example.com [103]: "
read s3ip
s3ip=${s3ip:=103}

echo -n "IP адреc (только 4-й октет) сервера serverd-$suffix.lab.example.com [104]: "
read s4ip
s4ip=${s4ip:=104}


tee -a /etc/hosts << _EOF_
$netaddr.$wsip ws-$suffix.lab.example.com ws-$suffix ws
$netaddr.$s1ip servera-$suffix.lab.example.com servera.lab.example.com servera-$suffix sa
$netaddr.$s2ip serverb-$suffix.lab.example.com serverb.lab.example.com serverb-$suffix sb
$netaddr.$s3ip serverc-$suffix.lab.example.com serverc.lab.example.com serverc-$suffix sc
$netaddr.$s4ip serverd-$suffix.lab.example.com serverd.lab.example.com serverd-$suffix sd
_EOF_

hostnamectl set-hostname ws-$suffix.lab.example.com
ssh sa@sa -t "hostnamectl set-hostname servera-$suffix.lab.example.com"
ssh sa@sb -t "hostnamectl set-hostname serverb-$suffix.lab.example.com"
ssh sa@sc -t "hostnamectl set-hostname serverc-$suffix.lab.example.com"
ssh sa@sd -t "hostnamectl set-hostname serverd-$suffix.lab.example.com"