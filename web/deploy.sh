#!/bin/bash

# Mudando o proprieário do arquio
sudo chown tomcat.tomcat /tmp/alura-forum.war


# Movendo o arquivo para deploy
sudo mv /tmp/alura-forum.war /opt/tomcat/tomcat8/webapps/
