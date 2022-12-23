#!/bin/bash


echo "$CERTBOT_VALIDATION"

scp -i /root/.ssh/id_rsa root@192.168.0.6:/etc/tinydns/root/zonak/hvgint.hu /var/www/certint/

curdate=$(date +'%Y%m%d')"01"

echo "$curdate"

sed -r -i -- "s/^(.*hostmaster.hvg.hu:)([^:]*)(:.*)/\1$curdate\3/" hvgint.hu
sed -i -- "s|_acme-challenge.hvgint.hu:.*:|_acme-challenge.hvgint.hu:$CERTBOT_VALIDATION:|" hvgint.hu

scp -i /root/.ssh/id_rsa /var/www/certint/hvgint.hu root@192.168.0.6:/etc/tinydns/root/zonak/

ssh root@192.168.0.6 -i /root/.ssh/id_rsa 'cd /etc/tinydns/root && ./commit'

sleep 40

host -t txt _acme-challenge.hvgint.hu 192.168.0.6

res=$(host -t txt _acme-challenge.hvgint.hu 192.168.0.6 | grep $CERTBOT_VALIDATION | wc -l)

#echo "$res"


if [[ $res -eq 1 ]]
then
	echo "Good news. The DNS successfully updated."
	exit 0
else
	echo "Something wrong. Please try again!"
	exit 1
fi