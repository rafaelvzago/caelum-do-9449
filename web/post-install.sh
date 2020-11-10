sudo echo "SUA_CHAVE_SSH" >> /home/vagrant/.ssh/authorized_keys

# Instalando o tomcat
sudo useradd -r -m -U -d /opt/tomcat -s /bin/false tomcat
sudo tar xf /tmp/apache-tomcat-8.5.47.tar.gz -C /opt/tomcat
sudo mv /opt/tomcat/apache-tomcat-8.5.47 /opt/tomcat/tomcat8
sudo mv /tmp/tomcat.service /etc/systemd/system
#sudo mv /tmp/alura-forum.war /opt/tomcat/tomcat8/webapps
sudo ufw allow 8080
sudo chgrp -R tomcat /opt/tomcat
sudo chown -R tomcat /opt/tomcat

# GlowRoot
sudo mv /tmp/glowroot.zip /opt/glowroot.zip
sudo unzip /opt/glowroot.zip -d /opt
sudo rm /opt/glowroot.zip
sudo mv /tmp/admin.json /opt/glowroot/admin.json
sudo chgrp -R tomcat /opt/glowroot
sudo chown -R tomcat /opt/glowroot

# Iniciando o tomcat
sudo systemctl daemon-reload
sudo systemctl restart tomcat
sudo systemctl enable tomcat

# Entrada na crontab
sudo mv /tmp/deploy.sh /home/vagrant/
sudo chmod +x /home/vagrant/deploy.sh
sudo echo "* * * * * /home/vagrant/deploy.sh" >> /home/vagrant/minha_crontab
sudo dos2unix /home/vagrant/deploy.sh
sudo crontab /home/vagrant/minha_crontab
sudo rm -f minha_crontab

