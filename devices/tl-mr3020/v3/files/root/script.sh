#!/bin/ash

#SCRIPT ENCARGADO DE CAMBIAR LA CONFIGURACION DE DNSMASQ SI NO HAY INTERNET

CONECTION=$(ping -c 3 google.com | grep -i % | awk '{print $(NF-2)}')
STABLISHED=$(cat /etc/dnsmasq.conf)

if [ "$CONECTION" == "0%"  ] && [ "$STABLISHED" != "#" ]; then
	
	echo "#">/etc/dnsmasq.conf
	echo $(/etc/init.d/dnsmasq restart)
elif [ "$CONECTION" != "0%" ] && [ "$STABLISHED" == "#"  ]; then
	
	echo "address=/#/192.168.1.1">/etc/dnsmasq.conf
	echo $(/etc/init.d/dnsmasq restart)
fi
