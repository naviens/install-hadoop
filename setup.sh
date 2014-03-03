#!/bin/sh
echo "------> Installing open SSh Server"

__apt_get_noinput() {
    apt-get install -y -o DPkg::Options::=--force-confold $@
}
apt-get update
__apt_get_noinput ssh
apt-get update
echo "------> Downloading Hadoop 2.2.0 package"
wget -c http://apache.mirrors.hoobly.com/hadoop/common/stable2/hadoop-2.2.0.tar.gz
echo "------> Installing Hadoop Package"
tar -xvzf hadoop-2.2.0.tar.gz
mv hadoop-2.2.0 /home/$USER/hadoop-yarn
chmod -R 755 /home/$USER/hadoop-yarn
cp conf/yarn/core-site.xml /home/$USER/hadoop-yarn/etc/hadoop/core-site.xml
cp conf/yarn/hdfs-site.xml /home/$USER/hadoop-yarn/etc/hadoop/hdfs-site.xml
cp conf/yarn/mapred-site.xml /home/$USER/hadoop-yarn/etc/hadoop/mapred-site.xml
cp conf/yarn/yarn-site.xml /home/$USER/hadoop-yarn/etc/hadoop/yarn-site.xml
