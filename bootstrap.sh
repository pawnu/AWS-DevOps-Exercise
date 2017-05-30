#!/usr/bin/env bash

#Part 1: Copy file from shared directory
###############################################################################
echo "Copying files from shared folder.."
cd /tmp/shared
sudo scp java.tar.gz /opt/
sudo scp maven.tar.gz /opt/
sudo scp jenkins_2.1_all.deb /home/vagrant/Desktop
sudo scp jira.bin /opt/
sudo scp response.varfile /opt/
sudo scp nexus-2.14.4-03-bundle.tar.gz /usr/local
cd /opt/

if [ "$(. /etc/os-release; echo $NAME)" = "Ubuntu" ]; then
  sudo apt-get update 
else
  sudo yum update
fi
#Part 2: install java and mavan
###############################################################################
echo "Installing Java and Maven.."
sudo tar zxvf maven.tar.gz
sudo tar zxvf java.tar.gz
sudo update-alternatives --install /usr/bin/java java /opt/jdk1.8.0_45/bin/java 100
sudo update-alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_45/bin/javac 100
sudo update-alternatives --install /usr/bin/mvn mvn /opt/apache-maven-3.3.9/bin/mvn 100

#edit profile with maven 
sudo echo "export M2_HOME=/opt/apache-maven-3.3.9" >> /etc/profile
sudo echo "export M2=$M2_HOME/bin" >> /etc/profile
sudo echo "export PATH=$M2:$PATH" >> /etc/profile
#activate the environment variable by refreshing the profile
source /etc/profile

#Part 3: Install Git
###############################################################################
echo "Installing Git.."
if [ "$(. /etc/os-release; echo $NAME)" = "Ubuntu" ]; then
	sudo apt-get install -y git
else
  sudo yum install -y git
fi
#Part 4: Install Jenkins
###############################################################################
echo "Installing Jenkins.."
cd /home/vagrant/Desktop
sudo dpkg -i jenkins_2.1_all.deb
sudo apt-get install -y -f
sudo apt-get install -y jenkins
sudo service jenkins start

#Part 5: Install Jira
###############################################################################
echo "Installing Jira.."
cd /opt/
sudo chmod a+x jira.bin
sudo ./jira.bin -q -varfile response.varfile

#Part 6: Install Nexus
###############################################################################
echo "Installing Nexus.."
cd /usr/local
sudo tar xvzf nexus-2.14.4-03-bundle.tar.gz
sudo ln -s nexus-2.14.4-03 nexus
echo "1" | sudo update-alternatives --config java
sudo chown -R vagrant nexus* sonatype-work 
cd /usr/local/nexus
./bin/nexus console
./bin/nexus start

#Part 7: Install Zabbix
###############################################################################
echo "Installing Zabbix.."
cd /opt/
wget http://repo.zabbix.com/zabbix/2.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_2.4-1+trusty_all.deb 
sudo dpkg -i zabbix-release_2.4-1+trusty_all.deb
sudo apt-get install -y zabbix-server-mysql zabbix-frontend-php php5-mysql

#Part 8: Verify Installation
###############################################################################
java -version
mvn -v
git --version
sudo service jenkins status
ps -ef | grep JIRA
./bin/nexus status