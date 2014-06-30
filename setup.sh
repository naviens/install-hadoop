#!/bin/sh

prefix=$1
user=`basename $prefix`
echo "------> Installing For user "$user
HOME_DIR=/home/$prefix/yarn
source $HOME/.bashrc
mkdir -p $HOME_DIR
# mkdir -p $HOME_DIR/yarn_data/hdfs/namenode
# mkdir -p $HOME_DIR/yarn_data/hdfs/datanode

echo "Select Package"
echo "1.hadoop 1.2.1 >"
echo "2.hadoop 2.2.0 >"
echo "3.hadoop 2.3.0 >"
echo "4.hadoop 2.4.0 >"
echo -n "select the option 1 or 2 or 3 or 4: "
read options
if [ $options -eq 1 ]; then
    echo "------> Downloading hadoop 1.2.1..........."
	YARN_HOME_DIR=$HOME_DIR/hadoop-1.2.1
	if [ ! -f hadoop-1.2.1.tar.gz ]; then
	    echo "Downloading File....!"
	    wget -c http://apache.mesi.com.ar/hadoop/common/stable1/hadoop-1.2.1.tar.gz
	else
	    echo "Using local File..."
	fi
	echo "------> Installing Hadoop 1.2.1 Package"
	tar xzf hadoop-1.2.1.tar.gz
	mv hadoop-1.2.1 $YARN_HOME_DIR
elif [ $options -eq 2 ]; then
    echo "------> Downloading hadoop 2.2.0..........."
	YARN_HOME_DIR=$HOME_DIR/hadoop-2.2.0
	if [ ! -f hadoop-2.2.0.tar.gz ]; then
	    echo "Downloading File....!"
	    wget -c http://apache.mirrors.hoobly.com/hadoop/common/stable2/hadoop-2.2.0.tar.gz
	else
	    echo "Using local File..."
	fi
	echo "------> Installing Hadoop 2.2.0 Package"
	tar xzf hadoop-2.2.0.tar.gz
	mv hadoop-2.2.0 $YARN_HOME_DIR
elif [ $options -eq 3 ]
then
    echo "------> Downloading Hadoop 2.3.0..........."
	YARN_HOME_DIR=$HOME_DIR/hadoop-2.3.0
    if [ ! -f hadoop-2.3.0.tar.gz ]; then
        echo "Downloading File....!"
        wget -c http://apache.mirrors.pair.com/hadoop/common/hadoop-2.3.0/hadoop-2.3.0.tar.gz
    else
        echo "Using local File..."
    fi
	echo "------> Installing Hadoop 2.3.0 Package"
	tar xzf hadoop-2.3.0.tar.gz
	mv hadoop-2.3.0 $YARN_HOME_DIR
elif [ $options -eq 4 ]
then
    echo "------> Downloading Hadoop 2.4.0..........."
	YARN_HOME_DIR=$HOME_DIR/hadoop-2.4.0
    if [ ! -f hadoop-2.4.0.tar.gz ]; then
        echo "Downloading File....!"
        wget -c http://apache.mirrors.hoobly.com/hadoop/common/hadoop-2.4.0/hadoop-2.4.0.tar.gz
    else
        echo "Using local File..."
    fi
	echo "------> Installing Hadoop 2.4.0 Package"
	tar xzf hadoop-2.4.0.tar.gz
	mv hadoop-2.4.0 $YARN_HOME_DIR
else
    echo "--------> Invalid Option.........."
    exit
fi

chmod -R 755 $YARN_HOME_DIR

mkdir $YARN_HOME_DIR/input
cp -rf file $YARN_HOME_DIR/input/

if [ $options -eq 1 ]
then
    echo "------> Configuring 1.2.1..........."
    cp -rf conf/core-site.xml $YARN_HOME_DIR/conf/core-site.xml
    cp -rf conf/mapred-site.xml $YARN_HOME_DIR/conf/mapred-site.xml
    cp -rf conf/mapred-site.xml $YARN_HOME_DIR/conf/mapred-site.xml
    awk '{gsub("hadoop", "'${1}'", $0); print}' > $YARN_HOME_DIR/conf/hdfs-site.xml < conf/hdfs-site.xml
    awk '{gsub("# export JAVA_HOME=/usr/lib/j2sdk1.5-sun", "export JAVA_HOME=/usr/", $0); print}' > $YARN_HOME_DIR/conf/hadoop-env.sh < conf/hadoop-env.sh
    cd $YARN_HOME_DIR/
    bin/hadoop namenode -format
    # Start hadoop daemons.
    bin/start-all.sh
else
    echo "--------> Configuring 2.X .........."
    cp -rf conf/yarn/core-site.xml $YARN_HOME_DIR/etc/hadoop/core-site.xml
    cp -rf conf/yarn/mapred-site.xml $YARN_HOME_DIR/etc/hadoop/mapred-site.xml
    cp -rf conf/yarn/yarn-site.xml $YARN_HOME_DIR/etc/hadoop/yarn-site.xml
    awk '{gsub("hadoop", "'${1}'", $0); print}' > $YARN_HOME_DIR/etc/hadoop/hdfs-site.xml < conf/yarn/hdfs-site.xml
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
fi

echo "------> Verifying Installation For user "$user
jps

echo "---------> Successfully Installed Hadoop on your machine <--------------"
echo "---------> waiting for hadoop daemons <---------------"
sleep 20
echo "Uploading Wordcount program to hdfs....."
bin/hadoop dfs -copyFromLocal input /input
sleep 5
echo "Executing Sample Hello world Example....."
if [ $options -eq 1 ]; then
    echo "Skipping examples....."
    #bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.2.0.jar wordcount /input /output
elif [ $options -eq 2 ]; then
    bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.2.0.jar wordcount /input /output
elif [ $options -eq 3 ]; then
    bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.3.0.jar wordcount /input /output
elif [ $options -eq 4 ]; then
    bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.4.0.jar wordcount /input /output
fi
