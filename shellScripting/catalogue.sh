#!/bin/bash

##Installing FRONT END
LOG_FILE=/tmp/roboshop.catalogue
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

echo "Installing nodejs "
sudo yum install nodejs make gcc-c++ -y
status_check $?


curl -s -L -o /tmp/catalogue.zip "https://dev.azure.com/DevOps-Batches/f4b641c1-99db-46d1-8110-5c6c24ce2fb9/_apis/git/repositories/1a7bd015-d982-487f-9904-1aa01c825db4/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"&>>LOG_FILE

echo "make catalogue dir"
cd /home/roboshop
mkdir catalogue
status_check $?

cd catalogue
unzip /tmp/catalogue.zip &>>LOG_FILE
status_check $?


npm install --unsafe-perm &>>$LOG_FILE
status_check $?
chown roboshop:roboshop  /home/roboshop -R

