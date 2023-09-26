echo -e "\e[32m Install python \e[0m"
yum install python36 gcc python3-devel -y &>>/tmp/roboshop.log

echo -e "\e[32m Add application user \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33m Create application directory \e[0m"
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[34m Download application content\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[32m Extract application content \e[0m"
unzip /tmp/payment.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[33m Install application dependencies \e[0m"
pip3.6 install -r requirements.txt &>>/tmp/roboshop.log

echo -e "\e[34m setpu systemD file \e[0m"
cp /home/centos/roboshop-shell/payment.service /etc/systemd/system/payment.service &>>/tmp/robosho.log

echo -e "\e[34m Start payment service \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable payment &>>/tmp/roboshop.log
systemctl start payment &>>/tmp/roboshop.log