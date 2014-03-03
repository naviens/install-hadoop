#!/bin/sh
echo "------> Installing For user "$1
source .bashrc
mkdir -p $HOME/yarn/yarn_data/hdfs/namenode
mkdir -p $HOME/yarn/yarn_data/hdfs/datanode
echo "------> Downloading Hadoop 2.2.0 package"
wget -c http://apache.mirrors.hoobly.com/hadoop/common/stable2/hadoop-2.2.0.tar.gz
echo "------> Installing Hadoop Package"
tar -xvzf hadoop-2.2.0.tar.gz
mv hadoop-2.2.0 /home/$1/yarn/hadoop-2.2.0
chmod -R 755 /home/$1/yarn/hadoop-2.2.0
cp -rf conf/yarn/core-site.xml /home/$1/yarn/hadoop-2.2.0/etc/hadoop/core-site.xml
cp -rf conf/yarn/mapred-site.xml /home/$1/yarn/hadoop-2.2.0/etc/hadoop/mapred-site.xml
cp -rf conf/yarn/yarn-site.xml /home/$1/yarn/hadoop-2.2.0/etc/hadoop/yarn-site.xml
awk '{gsub("hadoop", "'${1}'", $0); print}' > /home/$1/yarn/hadoop-2.2.0/etc/hadoop/hdfs-site.xml < conf/yarn/hdfs-site.xml
mkdir /home/$1/yarn/hadoop-2.2.0/input
cp -rf file /home/$1/yarn/hadoop-2.2.0/input/
cp conf/stop.sh /home/$1/yarn/hadoop-2.2.0/
cp conf/start.sh /home/$1/yarn/hadoop-2.2.0/
cd /home/$1/yarn/hadoop-2.2.0/
bin/hadoop namenode -format
# HDFS(NameNode & DataNode).
sbin/hadoop-daemon.sh start namenode
sbin/hadoop-daemon.sh start datanode
# MR(Resource Manager, Node Manager & Job History Server).
sbin/yarn-daemon.sh start resourcemanager
sbin/yarn-daemon.sh start nodemanager
sbin/mr-jobhistory-daemon.sh start historyserver

echo "------> Verifying Installation For user "$1
jps

echo "---------> Successfully Installed Hadoop on your machine <--------------"
echo "---------> waiting for hadoop daemons <---------------"
sleep 20
echo "Uploading Wordcount program to hdfs....."
bin/hadoop dfs -copyFromLocal input /input
sleep 5
echo "Executing Sample Hello world Example....."
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.2.0.jar wordcount /input /output