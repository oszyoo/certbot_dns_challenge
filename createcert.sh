#!/bin/bash

certbot certonly --text --agree-tos --email $1 --expand -d *.$2 -n --manual-public-ip-logging-ok --preferred-challenges dns --manual --manual-auth-hook $3 --reuse-key

#certbot certonly --text --agree-tos --email k.osztrovics@hvg.hu --expand -d vcsa.hvgint.hu -n --manual-public-ip-logging-ok --preferred-challenges dns --manual --manual-auth-hook /var/www/certint/subdomain-updatedns.sh --reuse-key --force-renewal
