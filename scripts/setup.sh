sudo su -
yum install -y git
cat > /etc/yum.repos.d/mongodb.repo

[MongoDB]
name=MongoDB Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64
gpgcheck=0
enabled=1

yum install -y mongodb-org
mkdir -p /data/db
mongod &

logout

mkdir repo
cd repo
git clone https://github.com/livnats/traffitruck.git

wget http://apache.spd.co.il/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
sudo tar -zxvf apache-maven-3.3.9-bin.tar.gz -C /opt
sudo ln -s /opt/apache-maven-3.3.9/bin/mvn /bin/mvn
rm -rf http://apache.spd.co.il/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz

sudo yum install -y java-1.8.0-openjdk-devel.x86_64
sudo alternatives --install /usr/bin/java java /usr/lib/jvm/java-1.8.0-openjdk/bin/java 20000
sudo alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-1.8.0-openjdk/bin/javac 20000
sudo /usr/sbin/alternatives --config java
sudo /usr/sbin/alternatives --config javac

#sudo rm /usr/jaiva/latest
sudo mkdir /usr/java
sudo ln -s /usr/lib/jvm/java-1.8.0-openjdk /usr/java/latest

#echo "export JAVA_HOME=/usr/java/jdk1.7.0_55" >> ~/.bashrc
#source ~/.bashrc

# CI/CD
cd /home/ec2-user/repo/traffitruck/ ; git fetch ; git rebase ; mvn clean install ; kill `pidof java` ; sleep 1 ; sudo mvn spring-boot:start -P web

# Create an admin user
sudo mvn spring-boot:run -P adminCreator -Drun.arguments="oda,oda"

