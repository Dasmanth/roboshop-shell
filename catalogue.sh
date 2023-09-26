component=catalogue

echo -e "\e[32m configuring nodejs repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[33m installation of nodejs \e[0m"
yum  install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[32m add application user \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33m Create application directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app

echo -e "\e[32m downlaod application content \e[0m"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[33m extract application content \e[0m"
unzip /tmp/$component.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[33m install nodejs dependencies \e[0m"
npm install &>>/tmp/roboshop.log

echo -e "\e[32m setup systemd service\e[0m"
cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service &>>/tmp/roboshop.log

echo -e "\e[32m start $component service \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable $component &>>/tmp/roboshop.log
systemctl start $component &>>/tmp/roboshop.log

echo -e "\e[32m copy mongoDb repo file \e[0m"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log

echo -e "\e[33m Install mongoDb client \e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[32m Load schema \e[0m"
mongo --host 172.31.26.22 </app/schema/$component.js &>>/tmp/roboshop.log

