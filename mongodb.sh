echo -e "\e[33mcopy mongodb repo file\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log

echo -e "\e[33minstalling mongodb server\e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.log

echo -e "\e[32mUpdate mongodb listen address\e[0m"
sed -i 's/127.0.0.0/0.0.0.0' /etc/mongod.conf &>>/tmp/roboshop.conf

echo -e "\e[33mstart mongodb server\e[0m"
systemctl start mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log