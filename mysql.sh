echo -e "\e[32m Disable old mysql \e[0m"
yum module disable mysql -y &>>/tmp/roboshop.log

echo -e "\e[33m Install mysql \e[0m"
yum install mysql-community-server -y &>>/tmp/roboshop.log

echo -e "\e[32m Start the mysql service \e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl start mysqld &>>/tmp/roboshop.log

echo -e "\e[33m Setup mysql password \e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/roboshop.log