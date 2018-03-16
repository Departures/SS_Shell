#!/bin/bash
######安装shadwsocks
#0.安装epel-release
apt-get -y install epel-release
#1.安装python-pip
apt-get -y install python-pip
pip install --upgrade pips
apt-get clean all
#2.安装shdowsocks
pip install shadowsocks
#3.配置服务端pp
cd /etc
touch shadowsocks.json
echo -e "#运行 ssserver -c /etc/shadowsocks.json -d start 启动SS服务" >> shadowsocks.json
echo -e "{" >> shadowsocks.json
##在ip_addr填入你的ip地址
echo -e "\t\"server\":\"ip_addr\"," >> shadowsocks.json
echo -e "\t\"local_address\":\"127.0.0.1\"," >> shadowsocks.json
echo -e "\t\"local_port\":1080," >> shadowsocks.json
echo -e "\t\"timeout\":300," >> shadowsocks.json
echo -e "\t\"method\":\"aes-256-cfb\"," >> shadowsocks.json
echo -e "\t\"fast_open\": false," >> shadowsocks.json
echo -e "\t\"workers\":\"5\"," >> shadowsocks.json
echo -e "\t\"port_password\":{" >> shadowsocks.json
##server_port和password分别为你的端口和密码，可以用json格式添加多个端口和密码
echo -e "\t\"server_port\":\"password\"" >> shadowsocks.json
echo -e "\t}" >>shadowsocks.json
echo -e "}" >> shadowsocks.json
chmod 755 /etc/shadowsocks.json
#4.启动shadowsocks,将其设置成服务启动
cd ~
cd /etc/systemd/system
touch shadowsocks.service
echo -e "[Unit]\n\
Description=Shadowsocks\n\
[Service]\n\
TimeoutStartSec=0\n\
ExecStart=/usr/bin/ssserver -c /etc/shadowsocks.json\n\
[Install]\n\
WantedBy=multi-user.target"  >> shadowsocks.service
#5.启动服务
echo -e "10秒后将打开/etc/shadowsocks.json"
echo -e "请将ip_addr、server_port、password改为你自己的服务器IP、端口、密码"
sleep 10
vim /etc/shadowsocks.json
echo -e "然后运行'ssserver -c /etc/shadowsocks.json -d start'启动SS"
