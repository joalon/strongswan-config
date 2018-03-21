#!/bin/bash


function log_verbose(){
	if [[ "$VERBOSE" -eq 1 ]]; then
		log "$@"
	fi
}

function log(){
	echo
	echo "$@"
	echo
}



ca_key=/etc/strongswan/ipsec.d/private/strongswanKey.pem


log "Generating CA key
$ca_key"

strongswan pki --gen --type rsa 4096 --outform pem > $ca_key 
chmod 600 $ca_key


ca_cert=/etc/strongswan/ipsec.d/cacerts/strongswanCert.pem

log "CA key generated
Generating CA cert
$ca_cert"


strongswan pki --self --ca --lifetime 3650 --outform pem \
	--in $ca_key --type rsa \
	--dn "C=SE, O=strongSwan, CN=strongSwan Root CA" \
	> $ca_cert 

host_key=/etc/strongswan/ipsec.d/private/vpnHostKey.pem
log "CA cert generated
Generating host key
$host_key"

strongswan pki --gen --type rsa --size 2048 --outform pem > $host_key
chmod 600 $host_key


host_cert=/etc/strongswan/ipsec.d/certs/vpnHostCert.pem

log "Host key generated
Generating host cert
$host_cert"

ip=$(curl ifconfig.co 2>/dev/null)
log_verbose "Using ip: $ip"
strongswan pki --pub --in "$host_key" --type rsa | \
	strongswan pki --issue --lifetime 730 --outform pem \
	--cacert "$ca_cert" \
	--cakey "$ca_key" \
	--dn "C=SE, O=strongSwan, CN=vpn.joalon.se" \
	--san vpn.joalon.se --san @$ip --san $ip \
	--flag serverAuth --flag ikeIntermediate \
	> "$host_cert"


client_key=/etc/strongswan/ipsec.d/private/ClientKey.pem

log "Host cert generated
Generating client key
$client_key"

strongswan pki --gen --type rsa --size 2048 --outform pem > "$client_key"
chmod 600 $client_key

client_cert=/etc/strongswan/ipsec.d/certs/ClientCert.pem
log "Client key generated
Generating client cert
$client_cert"

strongswan pki --pub --in $client_key --type rsa | \
	strongswan pki --issue --lifetime 730 --outform pem \
	--cacert "$ca_cert" \
	--cakey "$ca_key" \
	--dn "C=SE, O=strongSwan, CN=admin@joalon.se" \
	--san admin@joalon.se \
	> $client_cert


openssl pkcs12 -export -name "Admin VPN client certificate" \
	-inkey $client_key \
	-in $client_cert \
	-certfile $ca_cert \
	-caname "strongSwan Root CA" \
	-out ~/Client.p12

