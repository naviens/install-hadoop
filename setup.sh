wget -c http://www.webhostingjams.com/mirror/apache/hadoop/common/stable2/hadoop-2.2.0.tar.gz
tar -zxf hadoop-2.2.0.tar.gz
mv hadoop-2.2.0 /home/$USER/hadoop-2.2.0
cp conf/core-site.xml /home/$USER/hadoop-2.2.0/conf/core-site.xml
cp conf/hdfs-site.xml /home/$USER/hadoop-2.2.0/conf/hdfs-site.xml
cp conf/mapred-site.xml /home/$USER/hadoop-2.2.0/conf/mapred-site.xml
