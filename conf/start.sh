#!/bin/sh
echo "Starting Hadoop Daemons....."
# HDFS(NameNode & DataNode).
sbin/hadoop-daemon.sh start namenode
sbin/hadoop-daemon.sh start datanode
# MR(Resource Manager, Node Manager & Job History Server).
sbin/yarn-daemon.sh start resourcemanager
sbin/yarn-daemon.sh start nodemanager
sbin/mr-jobhistory-daemon.sh start historyserver