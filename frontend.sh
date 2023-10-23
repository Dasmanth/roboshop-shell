echo -e "${color}Installing nginx server${nocolor}"
yum install nginx -y &>>/tmp/roboshop.log

echo -e "${color}Removing old app content${nocolor}"
rm -rf /usr/share/nginx/html/* &>>/tmp/robshop.log

echo -e "${color}Downloading frontend content${nocolor}"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/roboshop.log

echo -e "${color}Extracting the frontend content${nocolor}"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "${color}mupdate frontend configuration${nocolor}"
cp /home/centos/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "${color}mStart nginx server${nocolor}"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log