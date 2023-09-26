component=cart

echo -e "\e[34m Setup nodejs \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[32m Installation of nodejs \e[0m"
 yum install nodejs -y &>>/tmp/roboshop.log

 echo -e "\e[33m Add user \e[0m"
 useradd roboshop &>>/tmp/roboshop.log

 echo -e "\e[32m Create application directory \e[0m"
 mkdir /app

 echo -e "\e[33m Download application content \e[0m"
 curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/roboshop.log
 cd /app

 echo -e "\e[32m Extract application content \e[0m"
 unzip /tmp/cart.zip &>>/tmp/roboshop.log
 cd /app

 echo -e "\e[34m Install Cart \e[0m"
 npm install &>>/tmp/roboshop.log

 echo -e "\e33m Start the Cart \e[0m"
 systemctl daemon-reload &>>/tmp/roboshop.log
 systemctl enable cart &>>/tmp/roboshop.log
 systemctl start cart &>>/tmp/roboshop.log