Apache Hadoop Installation
==============

Apache Hadoop installation...


>``` Clone This github repo ```
---
>      $ git clone https://github.com/naviens/install-hadoop.git
>      $ cd install-hadoop

Steps to be done before running setup.sh

>``` Install ssh Server```
---
>      $ sudo apt-get install ssh
>      $ ssh-keygen -t rsa -P ""
>      $ ssh-copy-id -i ~/.ssh/id_rsa.pub localhost
>      $ ssh localhost
>      $ exit

>``` install OpenJdk 1.7```
---
>      sudo apt-get install openjdk-7-jdk


>``` Set JAVA_HOME in .bashrc```
---
>      export JAVA_HOME=/usr
>      export PATH=$PATH:$HOME/bin:$JAVA_HOME/bin

>``` Steps for Hadoop Installation```
---
>      $ sh setup.sh $USER
>      Valid Version nos [1.2.1, 2.5.2, 2.6.0]
>      Enter Hadoop Version No (Ex: 2.6.0) : 

>``` Note : If u get JAVA_HOME is not set error ```
---
>      add below line in hadoop-env.sh available at (HADOOP_HOME/etc/hadoop)
>      export JAVA_HOME=/usr

>```$ jps```
> (to verify running Hadoop Daemons)

Now Check your Word count program result at 

>```$ localhost:50070``` 
(output folder)

Thats it :)
