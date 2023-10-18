#!/bin/bash

# Delete all existing FTP users:
grep "/ftp/" /etc/passwd | cut -d":" -f1 | xargs -r -n1 deluser

ACCOUNTS=(
	"test,password"
)

for ACCOUNT in $ACCOUNTS; do
	NAME=$(echo $ACCOUNT | cut -d "," -f1)
	PASSWORD=$(echo $ACCOUNT | cut -d "," -f2)
	FOLDER="/data/$NAME"

	echo -e "$PASSWORD\n$PASSWORD" | adduser -h $FOLDER -s /sbin/nologin $NAME
	mkdir -p $FOLDER
	chown $NAME:$NAME $FOLDER
	unset NAME PASSWORD FOLDER
done

echo "Start vsftpd"
vsftpd /etc/vsftpd.conf
