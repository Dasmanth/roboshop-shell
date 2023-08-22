echo -e "\e[31mInstalling nginx server\e[0m"
yum install nginx -y

echo -e "\e[31mRemoving old app content\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[31mDownloading frontend content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[31mExtracting the frontend content\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

#we need to copy config file

echo -e "\e[33mStart nginx server\e[0m"
systemctl enable nginx
systemctl restart nginx