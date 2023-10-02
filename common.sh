color="\e[32m"
colors="\e[37m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"

app_presetup() {
   echo -e "${color} add application user ${nocolor}"
   useradd roboshop &>>${log_file}

   echo -e "${colors} Create application directory ${nocolor}"
   rm -rf ${app_path} &>>${log_file}
   mkdir ${app_path}

   echo -e "${color} downlaod application content ${nocolor}"
    curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
    cd ${app_path}

   echo -e "${colors} extract application content ${nocolor}"
   unzip /tmp/${component}.zip &>>${log_file}
   cd ${app_path}

}

systemd_setup() {

  echo -e "${color} start ${component} service ${nocolor}"
   systemctl daemon-reload &>>${log_file}
   systemctl enable ${component} &>>${log_file}
   systemctl start ${component} &>>${log_file}
}

nodejs() {

 echo -e "${color} configuring nodejs repos ${nocolor}"
 curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

 echo -e "${colors} installation of nodejs ${nocolor}"
 yum  install nodejs -y &>>${log_file}

 app_presetup


 echo -e "${colors} install nodejs dependencies ${nocolor}"
 npm install &>>${log_file}

 echo -e "${color} setup systemd service${nocolor}"
 cp /home/centos/roboshop-shell/${component}.service /etc/systemd/system/${component}.service &>>${log_file}

 systemd_setup

}

mongo_schema_setup () {

  echo -e "${color} copy mongoDb repo file ${nocolor}"
  cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}

  echo -e "${colors} Install mongoDb client ${nocolor}"
  yum install mongodb-org-shell -y &>>${log_file}

  echo -e "${color} Load schema ${nocolor}"
  mongo --host 172.31.26.22 <${app-path}/schema/${component}.js &>>${log_file}
}


maven () {

  echo -e "${color}Install maven ${nocolor}"
  yum install maven -y &>>$log_file

  app_presetup


  echo -e "${color}Download maven dependencies ${nocolor}"
  mvn clean package &>>$log_file
  mv target/${component}-1.0.jar ${component}.jar &>>$log_file

  echo -e "${color}Install mysql client ${nocolor}"
  yum install mysql -y

  echo -e "${color}Load schema ${nocolor}"
  mysql -h 172.31.26.201 -uroot -pRoboShop@1 < $app_path/schema/${component}.sql &>>$log_file

  echo -e "${color}${nocolor}"
  cp /home/centos/roboshop-shell/${component}.service /etc/systemd/system/${component}.service &>>/tmp/robosho.log

   systemd_setup
  }