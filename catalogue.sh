component=catalogue
color="\e[36m"
colors="\e[36m"
nocolor="\e[0m"

echo -e "${color} configuring nodejs repos ${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "${colors} installation of nodejs ${nocolor}"
yum  install nodejs -y &>>/tmp/roboshop.log

echo -e "${color} add application user ${nocolor}"
useradd roboshop &>>/tmp/roboshop.log

echo -e "${colors} Create application directory ${nocolor}"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app

echo -e "${color} downlaod application content ${nocolor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>/tmp/roboshop.log
cd /app

echo -e "${colors} extract application content ${nocolor}"
unzip /tmp/$component.zip &>>/tmp/roboshop.log
cd /app

echo -e "${colors} install nodejs dependencies ${nocolor}"
npm install &>>/tmp/roboshop.log

echo -e "${color} setup systemd service${nocolor}"
cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service &>>/tmp/roboshop.log

echo -e "${color} start $component service ${nocolor}"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable $component &>>/tmp/roboshop.log
systemctl start $component &>>/tmp/roboshop.log

echo -e "${color} copy mongoDb repo file ${nocolor}"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log

echo -e "${colors} Install mongoDb client ${nocolor}"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "${color} Load schema ${nocolor}"
mongo --host 172.31.26.22 </app/schema/$component.js &>>/tmp/roboshop.log

