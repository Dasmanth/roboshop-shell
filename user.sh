echo -e "\e[33m setup nodejs repo\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/robosho.log

echo -e "\e[32m Install nodejs \e[0m"
yum install nodejs -y &>>/tmp/robosho.log

echo -e"\e[32m Add user \e[0m"
useradd roboshop &>>/tmp/robosho.log

echo -e"\e[34m Create Application directory \e[0m"
mkdir /app

echo -e "\e[32m Download the Application Content \e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>/tmp/robosho.log
cd /app

echo -e "\e32m Extract the Application content \e[0m"
unzip /tmp/user.zip &>>/tmp/robosho.log
cd /app

echo -e "\e[32m Install User \e[0m"
npm install &>>/tmp/robosho.log

echo -e "\e[33m Start User \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable user &>>/tmp/roboshop.log
systemctl start user &>>/tmp/roboshop.log

echo-e "\e[33m Copy mongodb repo \e[0m"
yum install mongodb-org-shell -y &>>/tmp/robosho.log
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/user.js &>>/tmp/robosho.log