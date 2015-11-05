#!/bin/bash
source prettyprint.sh
# stopping on wrong password and error handing to be done
# colorization
# better output format
# Caching password for remote server

pp "Create roles freewave and postgres if they does not exist"
#createuser -d -e -E -l -P -r -s freewave
#createuser -d -e -E -l -P -r -s postgres

pp "Process Started....Please Close Local/ Destination DB connections if in use"
hostname=128.199.162.181
username=freewave
port=2146
remotedbname=qiddle_production
dbusername=freewave
PGPASSWORD=321fr33wav3

localdbname=qiddle_development
dumpfilename=$remotedbname-$(date +"%F")
#dumpfilename=$remotedbname-$(date +"%F-%T") #withtime

pp "Dumping the remote database..."
ssh -p$port $username@$hostname "PGPASSWORD=$PGPASSWORD pg_dump -i -w -Fc -b -U$dbusername -d$remotedbname -f$dumpfilename.dump"
#O, --no-owner          skip restoration of object ownership in plain-text format
#w, --no-password       No password prompt
#Fc, -format=c|d|t|p    output file format (custom, directory, tar, plain text (default))
#b, --blobs             include large objects in dump
#-v, --verbose          verbose mode

pp "Copying remote database archive file to local home folder"
scp -P$port -c blowfish $username@$hostname:$dumpfilename.dump ~/

ssh -p $Port $Username@$Hostname "rm -f $Directory/$Dumpfilename.sql.gz" >/dev/null 2>&1

pp "Using pg_restore to dropping existing db/ creating new db / Importing the dump"
dropdb --if-exists $localdbname
createdb $localdbname
pg_restore -U$dbusername -d$localdbname ~/$dumpfilename.dump

pp "Done."


