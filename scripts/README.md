# strongswan-config

A working strongswan ipsec tunneling config for a Centos 7 server

Config taken from https://wiki.archlinux.org/index.php/StrongSwan with minor corrections


1. Installation
Simple script that calls yum

2. Generate certs
Creates CA cert+key, server cert+key and client cert+key. Packages them to Client.p12 in ~

3. Distribute config
Copies configuration files in repo to /etc/strongswan


