echo -e "\e[34m Install maven \e[0m"
yum install maven -y &>>/tmp/roboshop.log

echo -e "\e[32m Add application user \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo-e "\e[32m Create app directory \e[0m"
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[33m Download application content \e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[32m Extract the application content \e[0m"
unzip /tmp/shipping.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[33m Download maven dependencies \e[0m"
mvn clean package &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/roboshop.log

echo -e "\e[33m Install mysql client \e[0m"
yum install mysql -y

echo -e "\e[34m Load schema \e[0m"
mysql -h 172.31.26.201 -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>/tmp/roboshop.log

echo -e "\e[32m \e[0m"
cp /home/centos/roboshop-shell/shipping.service /etc/systemd/system/shipping.service &>>/tmp/robosho.log
echo -e "\e[32m Start shipping service \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable shipping &>>/tmp/roboshop.log
systemctl start shipping &>>/tmp/roboshop.log