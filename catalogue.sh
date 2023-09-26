source common.sh
component=catalogue

echo -e "${color} configuring nodejs repos ${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

echo -e "${colors} installation of nodejs ${nocolor}"
yum  install nodejs -y &>>${log_file}

echo -e "${color} add application user ${nocolor}"
useradd roboshop &>>${log_file}

echo -e "${colors} Create application directory ${nocolor}"
rm -rf ${app-path} &>>${log_file}
mkdir ${app-path}

echo -e "${color} downlaod application content ${nocolor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>${log_file}
cd ${app-path}

echo -e "${colors} extract application content ${nocolor}"
unzip /tmp/$component.zip &>>${log_file}
cd ${app-path}

echo -e "${colors} install nodejs dependencies ${nocolor}"
npm install &>>${log_file}

echo -e "${color} setup systemd service${nocolor}"
cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service &>>${log_file}

echo -e "${color} start $component service ${nocolor}"
systemctl daemon-reload &>>${log_file}
systemctl enable $component &>>${log_file}
systemctl start $component &>>${log_file}

echo -e "${color} copy mongoDb repo file ${nocolor}"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}

echo -e "${colors} Install mongoDb client ${nocolor}"
yum install mongodb-org-shell -y &>>${log_file}

echo -e "${color} Load schema ${nocolor}"
mongo --host 172.31.26.22 <${app-path}/schema/$component.js &>>${log_file}

