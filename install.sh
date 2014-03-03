#!/bin/sh
echo "------> Installing For user "$1
source .bashrc
mkdir -p $HOME/yarn/yarn_data/hdfs/namenode
mkdir -p $HOME/yarn/yarn_data/hdfs/datanode
echo "------> Downloading Hadoop 2.2.0 package"
echo "------> Installing Hadoop Package"
tar -xvzf hadoop-2.2.0.tar.gz
mv hadoop-2.2.0 /home/$1/yarn/hadoop-2.2.0
chmod -R 755 /home/$1/yarn/hadoop-2.2.0
cp -rf conf/yarn/core-site.xml /home/$1/yarn/hadoop-2.2.0/etc/hadoop/core-site.xml
cp -rf conf/yarn/mapred-site.xml /home/$1/yarn/hadoop-2.2.0/etc/hadoop/mapred-site.xml
cp -rf conf/yarn/yarn-site.xml /home/$1/yarn/hadoop-2.2.0/etc/hadoop/yarn-site.xml
awk '{gsub("hadoop", "'${1}'", $0); print}' > /home/$1/yarn/hadoop-2.2.0/etc/hadoop/hdfs-site.xml < conf/yarn/hdfs-site.xml
