echo "------> Installing open SSh Server"

__apt_get_noinput() {
    apt-get install -y -o DPkg::Options::=--force-confold $@
}
apt-get update
__apt_get_noinput ssh
apt-get update
echo "------> Downloading Hadoop 2.2.0 package"
wget -c http://www.webhostingjams.com/mirror/apache/hadoop/common/stable2/hadoop-2.2.0.tar.gz
echo "------> Installing Hadoop Package"
tar -zxf hadoop-2.2.0.tar.gz
mv hadoop-2.2.0 /home/$USER/hadoop-2.2.0
cp conf/core-site.xml /home/$USER/hadoop-2.2.0/conf/core-site.xml
cp conf/hdfs-site.xml /home/$USER/hadoop-2.2.0/conf/hdfs-site.xml
cp conf/mapred-site.xml /home/$USER/hadoop-2.2.0/conf/mapred-site.xml
