sudo sed -i "s|#precedence ::ffff:0:0/96  100|precedence ::ffff:0:0/96  100/|" /etc/gai.conf
sudo apt-get update
sudo apt-get install -y openjdk-8-jre dos2unix unzip
