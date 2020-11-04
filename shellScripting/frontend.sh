#!/bin/bash
##Installing FRONT END
LOG_FILE=/tmp/roboshop.catalogue
rm -f $LOG_FILE

echo Intstalling nginx
yum install nginix -y>>$LOG_FILE
case $? in
  0)
    echo Successfully installed
    ;;
  *)
    echo Failure
    echo "refer log file $LOG_FILE"
    ;;
esac

echo -n "Download front end "
curl -s -L -o /tmp/frontend.zip "https://dev.azure.com/DevOps-Batches/f4b641c1-99db-46d1-8110-5c6c24ce2fb9/_apis/git/repositories/a781da9c-8fca-4605-8928-53c962282b74/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true">>$LOG_FILE
cd /usr/share/nginx/html
rm -rf *
echo extracting front end and moving the folder
unzip /tmp/frontend.zip
mv static/* .
rm -rf static README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf

echo enable and start nginx

#Enable nginx
systemctl enable nginx
case $? in
  0)
    echo Successfully enabled
    ;;
  *)
    echo Cannot enable
    echo "refer log file $LOG_FILE"
    ;;
esac

#Start nginx
systemctl start nginx
case $? in
  0)
    echo Successfully started
    ;;
  *)
    echo Failed to start
    echo "refer log file $LOG_FILE"
    ;;
esac


