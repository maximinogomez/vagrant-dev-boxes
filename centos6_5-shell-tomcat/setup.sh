### Maximino Gomez ###

# ----------------------------------------------------------------------------------------
sudo su

sudo yum clean all
sudo yum -y update
# ----------------------------------------------------------------------------------------

########## Java Installation / Setup ##########

sudo mkdir -p /usr/lib/jvm

wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
   http://download.oracle.com/otn-pub/java/jdk/7u60-b19/jdk-7u60-linux-x64.tar.gz

sudo tar zxvf jdk-7u60-linux-x64.tar.gz -C /usr/lib/jvm/
sudo rm jdk-7u60-linux-x64.tar.gz

sudo update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.7.0_60/bin/java" 1 
sudo update-alternatives --install "/usr/bin/jar" "jar" "/usr/lib/jvm/jdk1.7.0_60/bin/jar" 1 
sudo update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.7.0_60/bin/javac" 1 
sudo update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/lib/jvm/jdk1.7.0_60/bin/javaws" 1 

sudo update-alternatives --set java "/usr/bin/java" "/usr/lib/jvm/jdk1.7.0_60/bin/java"
sudo update-alternatives --set jar "/usr/bin/jar" "/usr/lib/jvm/jdk1.7.0_60/bin/jar"
sudo update-alternatives --set javac "/usr/bin/javac" "/usr/lib/jvm/jdk1.7.0_60/bin/javac"
sudo update-alternatives --set javaws "/usr/bin/javaws" "/usr/lib/jvm/jdk1.7.0_60/bin/javaws"

java -version
#----------------------------------------------------------------------------------------


########## Tomcat Installation / Setup ##########

wget http://mirror.olnevhost.net/pub/apache/tomcat/tomcat-7/v7.0.57/bin/apache-tomcat-7.0.57.tar.gz

### Install
sudo mkdir -p /usr/local 
sudo tar zxvf apache-tomcat-7.0.57.tar.gz -C /usr/local/ 

### Link
sudo ln -s /usr/local/apache-tomcat-7.0.57/ /usr/local/tomcat

###
touch /etc/init.d/tomcat 

TOMCAT_CONFIG='case $1 in
 start) 
 export JAVA_HOME=/usr/lib/jvm/jdk1.7.0_60/ 
 export CLASSPATH=/usr/local/tomcat/lib/servlet-api.jar 
 export CLASSPATH=/usr/local/tomcat/lib/jsp-api.jar 
 export JRE_HOME=/usr/lib/jvm/jdk1.7.0_60/ 
 echo "Tomcat is started" 
 sh /usr/local/tomcat/bin/startup.sh 
 ;; 
 stop) 
 export JRE_HOME=/usr/lib/jvm/jdk1.7.0_60/ 
 sh /usr/local/tomcat/bin/shutdown.sh 
 echo "Tomcat is stopped" 
 ;; 
 restart) 
 export JRE_HOME=/usr/lib/jvm/jdk1.7.0_60/ 
 sh /usr/local/tomcat/bin/shutdown.sh 
 echo "Tomcat is stopped" 
 sh /usr/local/tomcat/bin/startup.sh 
 echo "Tomcat is started" 
 ;; 
 *) 
 echo "Usage: /etc/init.d/tomcat start|stop|restart" 
 ;; 
esac 
exit 0'

echo "$TOMCAT_CONFIG" > /etc/init.d/tomcat

### SET PERMISSIONS
chmod 755 /etc/init.d/tomcat 

### Environment variable
touch /usr/local/tomcat/bin/setenv.sh
echo 'JAVA_OPTS="$JAVA_OPTS -Dfile.encoding=UTF-8 -server -Xms512m -Xmx1024m -XX:NewSize=256m -XX:MaxNewSize=256m -XX:PermSize=256m -XX:MaxPermSize=256m -XX:+DisableExplicitGC -Dspring.profiles.active=develop -Dspring.profile.active=develop"' >> /usr/local/tomcat/bin/setenv.sh
#----------------------------------------------------------------------------------------


### Start Tomcat
sudo /etc/init.d/tomcat start
