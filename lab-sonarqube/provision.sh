#/usr/bin/bash
useradd sonar
yum install wget unzip java-11-openjdk-devel -y
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.3.0.51899.zip
unzip sonarqube-9.3.0.51899.zip -d /opt/
mv /opt/sonarqube-9.3.0.51899 /opt/sonarqube
chown -R sonar:sonar /opt/sonarqube
touch /etc/systemd/system/sonar.service
echo > /etc/systemd/system/sonar.service
cat <<EOT >> /etc/systemd/system/sonar.service
[Unit]
Description=Sonarqube service
After=log.target network.target
[Service]
Type=forking
ExecStart=/opt/sonarqube/bin/linux-x86/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86/sonar.sh stop
User=sonar
Group=sonar
Resert=always
[Install]
WantedBy=multi-user.target
EOT
service sonar start

#Install sonar scanner
wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.7.0.2747-linux.zip
unzip sonar-scanner-cli-4.7.0.2747-linux.zip -d /opt/
mv /opt/sonar-scanner-cli-4.7.0.2747-linux /opt/sonar-scanner
chown -R sonar:sonar /opt/sonar-scanner
echo 'export PATH=$PATH:/opt/sonar-scanner/bin' | sudo tee-a /etc/profile
curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -
sudo yum install nodejs -y


