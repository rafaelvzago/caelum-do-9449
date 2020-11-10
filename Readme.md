# Curso de Devops DO25 - DO-9449

## Requisitos para o build da aplicação:

- JRE/JDK 8
- Maven > 3.0

## Documentação e repositórios

- Código fonte final do projeto: https://github.com/rafaelvzago/caelum-do-9449-cofigo-fonte
- Múltiplas chave SSH no mesmo computador: https://gist.github.com/jexchan/2351996
- Git Flow: https://www.atlassian.com/br/git/tutorials/comparing-workflows/gitflow-workflow
- Configurar o Jenkins com slaves: https://wiki.jenkins.io/display/JENKINS/Step+by+step+guide+to+set+up+master+and+agent+machines+on+Windows
- Gerador de crontab: https://crontab.guru/
- Reposótório de artefatos: https://jfrog.com/artifactory/
- Apostila: https://github.com/caelum/apostila-devops
- Vagrant boxes: https://app.vagrantup.com/boxes/search

## Configuração dos ambientes

### Configurando o servidor de banco de dados manualmente
```sh
vagrant up db 

# Em caso de configuração manual

ssh vagrant@IP # senha padrao é vagrant
# Adcionar a chave publica em ~/.ssh/authorized_keys com o nano
sudo passwd root # trocando a senha do root para vagrant
sudo hostnamectl set-hostname alura-db # trocando o nome do hostname
sudo reboot
sudo sed -i "s|#precedence ::ffff:0:0/96  100|precedence ::ffff:0:0/96  100/|" /etc/gai.conf
sudo apt-get install -y openjdk-8-jre dos2unix unzip
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install mysql-server -y # Colocar a senha 
sudo nano /etc/mysql/my.cnf # mudar o bind-address para 0.0.0.0
mysql -u root -p mestre
grant all privileges on *.* to root@'%' identified by 'root';
grant all privileges on alura_forum.* to alura@'%' identified by 'qwerty123';
flush privileges;
```

### Configurando o sevidor web manualmente
```sh
vagrant up web

# Em caso de configuração manual

sh vagrant@IP # senha padrao é vagrant
# Adcionar a chave publica em ~/.ssh/authorized_keys com o nano
sudo passwd root # trocando a senha do root para vagrant
sudo hostnamectl set-hostname alura-web # trocando o nome do hostname
sudo reboot
sudo sed -i "s|#precedence ::ffff:0:0/96  100|precedence ::ffff:0:0/96  100/|" /etc/gai.conf
sudo apt-get install -y openjdk-8-jre dos2unix unzip
sudo apt-get update && sudo apt-get upgrade -y
# Tomcat
sudo useradd -r -m -U -d /opt/tomcat -s /bin/false tomcat
sudo tar xf /vagrant/web/apache-tomcat-8.5.47.tar.gz -C /opt/tomcat
sudo mv /opt/tomcat/apache-tomcat-8.5.47 /opt/tomcat/tomcat8
sudo mv /vagrant/web/tomcat.service /etc/systemd/system
sudo ufw allow 8080
sudo chgrp -R tomcat /opt/tomcat
sudo chown -R tomcat /opt/tomcat
# GlowRoot
sudo mv /vagrant/web/glowroot.zip /opt/glowroot.zip
sudo unzip /opt/glowroot.zip -d /opt
sudo rm /opt/glowroot.zip
sudo mv /vagrant/web/admin.json /opt/glowroot/admin.json
sudo chgrp -R tomcat /opt/glowroot
sudo chown -R tomcat /opt/glowroot
# Finalizando a instalação do tomcat
sudo systemctl daemon-reload
sudo systemctl restart tomcat
sudo systemctl enable tomcat
# Script de deploy e crontab
sudo mv /vagrant/web/deploy.sh /root/
sudo chmod +x /root/deploy.sh
sudo echo "* * * * * /root/deploy.sh" >> /root/minha_crontab
sudo dos2unix /home/vagrant/deploy.sh
sudo crontab /root/minha_crontab
sudo rm -f /root/minha_crontab
```

### Configurando o Jenkins Manualmente
```sh
sudo vagrant@IP # senha padrao é vagrant
sudo add-apt-repository ppa:openjdk-r/ppa ## Adicionando o repositorio para o java 8
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install openjdk-8-jdk git maven -y
sudo update-alternatives --config java
sudo java -version
sudo update-alternatives --config javac
# Adcionar a chave publica em ~/.ssh/authorized_keys com o nano
sudo passwd root # trocando a senha do root para vagrant
sudo hostnamectl set-hostname alura-jenkins # trocando o nome do hostname
sudo reboot
mkdir jenkins
cd jenkins
wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war
sudo /var/lib/dpkg/info/ca-certificates-java.postinst configure # para corrigir os problemas de SSL
java -jar jenkins.war --httpPort=8082 # Copiar a chave de instalação do console
```

## Fazendo o build pelo VAGRANT (IAAC / Infraestrutura como código):

```sh
cd caelum-do25
vagrant up <MÁQUINA> # Ex: vagrant up DB
 ```

## Configurando o Jenkins 

- Iniciando o Jenkins manualmente na sua máquina: `java -jar jenkins.war --httpPort=8082`
- Não se esqueça de entrar em Configurar Jenkins > Global Tool Configuration e definir a sua instalação do JAVA e do Maven.

### Plugins do Jenkins
- git
- Maven Integration
- Green balls 
- Radiator View
- Test Results Analyzer

### Post Build Step

```
scp -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no"  target/alura-forum.war vagrant@<IP DO SERVIDOR WEB>:/tmp
```

### Contatos:

- Rafael Zago - rafaelvzago.com
