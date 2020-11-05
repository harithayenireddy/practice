#!/bin/bash


##MANGO DB

LOG_FILE=/tmp/mangodb.log
rm -f $LOG_FILE

status_check()
{
  case $1 in
  0)
    echo "SUCCESS"
    ;;
  *)
    echo "failed , plz check the log file $LOG_FILE"
    exit 1
    ;;
  esac
}


echo '[mongodb-org-4.2]

name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >/etc/yum.repos.d/mongodb.repo

#Install mango-db

sudo yum install -y mongodb-org &>>LOG_FILE
status_check $?

#Enbale mango-db
systemctl enable mongod
status_check $?


systemctl start mongod
status_check $?


Print "Update MangoDB config file"
sed -i -e "s/127.0.0.0/0.0.0.0" /etc/mongod.conf
status_check $?

#restart
systemctl restart mongod

curl -s -L -o /tmp/mongodb.zip "https://dev.azure.com/DevOps-Batches/ce99914a-0f7d-4c46-9ccc-e4d025115ea9/_apis/git/repositories/e9218aed-a297-4945-9ddc-94156bd81427/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true">>$LOG_FILE
status_check $?

cd /tmp
unzip mongodb.zip &>>LOG_FILE
status_check $?

mongo < catalogue.js &>>LOG_FILE

mongo < users.js &>>LOG_FILE


