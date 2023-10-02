source common.sh
component=catalogue
nodejs

echo -e "${color} copy mongoDb repo file ${nocolor}"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}

echo -e "${colors} Install mongoDb client ${nocolor}"
yum install mongodb-org-shell -y &>>${log_file}

echo -e "${color} Load schema ${nocolor}"
mongo --host 172.31.26.22 <${app-path}/schema/$component.js &>>${log_file}

