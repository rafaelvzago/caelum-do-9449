sudo mv /tmp/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
sudo mysql -u root -proot -e "create database alura_forum; create user 'alura'@'%' IDENTIFIED BY 'qwerty123'; grant select, insert, update, delete on alura_forum.* to 'alura'@'%';"
sudo mysql -u root -proot < /tmp/script-inicial.sql
sudo service mysql restart
sudo echo "SUA_CHAVE_SSH" >> /home/vagrant/.ssh/authorized_keys
