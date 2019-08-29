#instala
echo "Baixando e instalando o Zabbix Agent"
yum install -y wget
wget https://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-release-4.0-1.el7.noarch.rpm
rpm -Uvh zabbix-release-4.0-1.el7.noarch.rpm
yum install -y zabbix-agent

#limpa arquivo
echo "Limpando arquivo de configuração do Zabbix"
echo "" > /etc/zabbix/zabbix_agentd.conf

echo "Insert hostname:"
read name
echo "Hostname=$name" >> /etc/zabbix/zabbix_agentd.conf

echo "Insert proxy server IP:"
echo "proxy-cgo = 192.168.132.15"
echo "proxy-spo = 192.168.15.108"
echo "proxy-tpo = 192.168.224.64"
echo "proxy-aws = 10.10.255.59"
echo ""
read server
echo "Server=$server" >> /etc/zabbix/zabbix_agentd.conf

echo "PidFile=/var/run/zabbix/zabbix_agentd.pid" >> /etc/zabbix/zabbix_agentd.conf
echo "LogFile=/var/log/zabbix/zabbix_agentd.log" >> /etc/zabbix/zabbix_agentd.conf
echo "LogFileSize=0" >> /etc/zabbix/zabbix_agentd.conf
echo "DebugLevel=3" >> /etc/zabbix/zabbix_agentd.conf
echo "EnableRemoteCommands=1" >> /etc/zabbix/zabbix_agentd.conf
echo "HostnameItem=system.hostname" >> /etc/zabbix/zabbix_agentd.conf
echo "Include=/etc/zabbix/zabbix_agentd.d/*.conf" >> /etc/zabbix/zabbix_agentd.conf

echo "Iniciando serviço do Zabbix Agent e adicionando ele ao chkconfig"
systemctl enable zabbix-agent
service zabbix-agent start

echo "Por favor, execute o comando "service zabbix-agent status" para validar se está o serviço está running."
