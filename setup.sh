#!/bin/sh
echo "------> Installing For user "$1
HOME_DIR=/home/$1/yarn
source .bashrc
mkdir -p $HOME/yarn/yarn_data/hdfs/namenode
mkdir -p $HOME/yarn/yarn_data/hdfs/datanode

echo "Select Package"
echo "1.hadoop 2.2.0 >"
echo "2.hadoop 2.3.0 >"
echo -n "select the option 1 or 2 : "
read options
if [ $options -eq 1 ]; then
    echo "------> Downloading hadoop 2.2.0..........."
	YARN_HOME_DIR=/home/$1/yarn/hadoop-2.2.0
	if [ ! -f hadoop-2.3.0.tar.gz ]; then
	    echo "Downloading File....!"
	    wget -c http://apache.mirrors.hoobly.com/hadoop/common/stable2/hadoop-2.2.0.tar.gz
	else
	    echo "Using local File..."
	fi
	echo "------> Installing Hadoop 2.2.0 Package"
	tar -xvzf hadoop-2.2.0.tar.gz
	mv hadoop-2.2.0 $YARN_HOME_DIR	
elif [ $options -eq 2 ]
then
    echo "------> Downloading Hadoop 2.3.0..........."
	YARN_HOME_DIR=/home/$1/yarn/hadoop-2.3.0
    if [ ! -f hadoop-2.3.0.tar.gz ]; then
        echo "Downloading File....!"
        wget -c http://apache.mirrors.pair.com/hadoop/common/hadoop-2.3.0/hadoop-2.3.0.tar.gz
    else
        echo "Using local File..."
    fi
	echo "------> Installing Hadoop 2.3.0 Package"
	tar -xvzf hadoop-2.3.0.tar.gz
	mv hadoop-2.3.0 $YARN_HOME_DIR
else
    echo "--------> Invalid Option.........."
    exit
fi

chmod -R 755 $YARN_HOME_DIR
cp -rf conf/yarn/core-site.xml $YARN_HOME_DIR/etc/hadoop/core-site.xml
cp -rf conf/yarn/mapred-site.xml $YARN_HOME_DIR/etc/hadoop/mapred-site.xml
cp -rf conf/yarn/yarn-site.xml $YARN_HOME_DIR/etc/hadoop/yarn-site.xml
awk '{gsub("hadoop", "'${1}'", $0); print}' > $YARN_HOME_DIR/etc/hadoop/hdfs-site.xml < conf/yarn/hdfs-site.xml
mkdir $YARN_HOME_DIR/input
cp -rf file $YARN_HOME_DIR/input/
cp conf/stop.sh $YARN_HOME_DIR/
cp conf/start.sh $YARN_HOME_DIR/
cd $YARN_HOME_DIR/
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

if [ $options -eq 1 ]; then
    bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.2.0.jar wordcount /input /output
elif [ $options -eq 2 ]; then
    bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.3.0.jar wordcount /input /output
fi
