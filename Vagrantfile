Vagrant.configure("2") do |config|

  # Servidor de Homologacao Tomcat
  config.vm.define "homologacao" do |homologacao|
    homologacao.vm.box = "ubuntu/bionic64"
    homologacao.vm.network "private_network", ip: "192.168.33.8"
    #homologacao.vm.network "forwarded_port", guest: 8080, host: 8080
    homologacao.vm.provision "shell", path: "web/install.sh"
    homologacao.vm.provision "file", source: "web/apache-tomcat-8.5.47.tar.gz", destination: "/tmp/apache-tomcat-8.5.47.tar.gz"
    homologacao.vm.provision "file", source: "web/tomcat.service", destination: "/tmp/tomcat.service"
    homologacao.vm.provision "file", source: "web/deploy.sh", destination: "/tmp/deploy.sh"
    #homologacao.vm.provision "file", source: "target/alura-forum.war", destination: "/tmp/alura-forum.war"
    homologacao.vm.provision "shell", path: "web/post-install.sh"
  end

    # Servidor de Desenvolvimento Tomcat
    config.vm.define "dev" do |dev|
      dev.vm.box = "ubuntu/bionic64"
      dev.vm.network "private_network", ip: "192.168.33.9"
      #dev.vm.network "forwarded_port", guest: 8080, host: 8080
      dev.vm.provision "shell", path: "web/install.sh"
      dev.vm.provision "file", source: "web/apache-tomcat-8.5.47.tar.gz", destination: "/tmp/apache-tomcat-8.5.47.tar.gz"
      dev.vm.provision "file", source: "web/tomcat.service", destination: "/tmp/tomcat.service"
      dev.vm.provision "file", source: "web/deploy.sh", destination: "/tmp/deploy.sh"
      #dev.vm.provision "file", source: "target/alura-forum.war", destination: "/tmp/alura-forum.war"
      dev.vm.provision "shell", path: "web/post-install.sh"
    end

  # Servidor de Produção Tomcat
  config.vm.define "web" do |web|
    web.vm.box = "ubuntu/bionic64"
    web.vm.network "private_network", ip: "192.168.33.10"
    #web.vm.network "forwarded_port", guest: 8080, host: 8080
    web.vm.provision "shell", path: "web/install.sh"
    web.vm.provision "file", source: "web/apache-tomcat-8.5.47.tar.gz", destination: "/tmp/apache-tomcat-8.5.47.tar.gz"
    web.vm.provision "file", source: "web/tomcat.service", destination: "/tmp/tomcat.service"
    web.vm.provision "file", source: "web/deploy.sh", destination: "/tmp/deploy.sh"
    #web.vm.provision "file", source: "target/alura-forum.war", destination: "/tmp/alura-forum.war"
    web.vm.provision "file", source: "web/glowroot.zip", destination: "/tmp/glowroot.zip"
    web.vm.provision "file", source: "web/admin.json", destination: "/tmp/admin.json"    
    web.vm.provision "shell", path: "web/post-install.sh"
  end

  # Servidor de Banco de Dados MySQL
  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/bionic64"
    db.vm.network "private_network", ip: "192.168.33.11"
    #db.vm.network "forwarded_port", guest: 3306, host: 3307
    db.vm.provision "shell", path: "database/install.sh"
    db.vm.provision "file", source: "database/mysqld.cnf", destination: "/tmp/mysqld.cnf"
    db.vm.provision "file", source: "database/script-inicial.sql", destination: "/tmp/script-inicial.sql"
    db.vm.provision "shell", path: "database/post-install.sh"
  end
  
  # Servidor para o Jenkins
  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.box = "ubuntu/bionic64"
    #jenkins.disksize.size = "50GB"-> vagrant plugin install vagrant-disksize
    jenkins.vm.memory = 1024
    jenkins.vm.network "private_network", ip: "192.168.33.7"
    jenkins.vm.network "public_network"
  end
end
