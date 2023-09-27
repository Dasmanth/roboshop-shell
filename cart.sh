source common.sh
component=cart

echo -e "${color} Setup nodejs ${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

echo -e "${color} Installation of nodejs ${nocolor}"
 yum install nodejs -y &>>${log_file}

 echo -e "${color} Add user ${nocolor}"
 useradd roboshop &>>${log_file}

 echo -e "${color} Create application directory ${nocolor}"
 mkdir ${app_path}

 echo -e "${color} Download application content ${nocolor}"
 curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>${log_file}
 cd ${app_path}

 echo -e "${color} Extract application content ${nocolor}"
 unzip /tmp/cart.zip &>>${log_file}
 cd ${app_path}

 echo -e "${color} Install Cart ${nocolor}"
 npm install &>>${log_file}

 echo -e "\e33m Start the Cart ${nocolor}"
 systemctl daemon-reload &>>${log_file}
 systemctl enable cart &>>${log_file}
 systemctl start cart &>>${log_file}