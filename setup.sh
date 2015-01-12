#!/bin/sh

prefix=$1
user=`basename $prefix`
echo "------> Installing For user "$user
HOME_DIR=/home/$prefix/yarn
source $HOME/.bashrc
mkdir -p $HOME_DIR
# mkdir -p $HOME_DIR/yarn_data/hdfs/namenode
# mkdir -p $HOME_DIR/yarn_data/hdfs/datanode
echo "Valid Version nos are 1.2.1 , 2.4.0 , 2.5.2 , 2.6.0"
echo -n "Enter Hadoop Version No (Ex: 2.6.0) > "
read version
echo "Fetching Download url for Hadoop version $version "
echo ${#version}
if [ ${#version} -gt 2 ]
then
    YARN_HOME_DIR=$HOME_DIR/hadoop-${version}
    mkdir $YARN_HOME_DIR/input

    if [ "$version" = "1.2.1" ]
    then
        MYURL=`echo "http://apache.mirrors.hoobly.com/hadoop/common/stable1/hadoop-${version}.tar.gz"`
    else
        MYURL=`echo "http://apache.mirrors.hoobly.com/hadoop/common/stable2/hadoop-${version}.tar.gz"`
    fi

    echo "<<<<<<<<< Downloading url >>>>>>>>>>"
    echo $MYURL
    echo "<<<<<<<<< Yarn_home >>>>>>>>>>"
    echo "YARN_HOME_DIR=$HOME_DIR/hadoop-${version}"

    if [ ! -f hadoop-${version}.tar.gz ]; then
        echo "Downloading File....!"
        wget -c $MYURL
    else
        echo "Using local File..."
    fi
    echo "------> Installing Hadoop ${version} Package"
    tar xzf hadoop-${version}.tar.gz
    mv hadoop-${version} $YARN_HOME_DIR   

    # Code 2

    chmod -R 755 $YARN_HOME_DIR

    mkdir $YARN_HOME_DIR/input
    cp -rf file $YARN_HOME_DIR/input/

    if [ "$version" = "1.2.1" ]
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
    echo "Executing Wordcount Example....."
    if [ "$version" = "1.2.1" ]; then
        bin/hadoop jar hadoop-examples-${version}.jar wordcount /input /output
    else
        bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-${version}.jar wordcount /input /output
    fi
else
   echo "error"
fi
