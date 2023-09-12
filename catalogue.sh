echo -e "\e[32m setup node source \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[33m installation of nodejs \e[0m"
dnf install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[32m creaion of user \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[32m creation of app directory \e[0m"
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[32m downlaod catalogue content \e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[34m extract the content \e[0m"
unzip /tmp/catalogue.zip
cd /app
echo -e "\e[33m install npm \e[0m"
npm install

echo -e "\e[32m starting of catalogue service \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl start catalogue &>>/tmp/roboshop.log