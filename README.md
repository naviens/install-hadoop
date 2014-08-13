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

>      1. Hadoop 1.2.1

>      2. Hadoop 2.2.0

>      3. Hadoop 2.3.0

>      4. Hadoop 2.4.0

>      select required option 1 or 2 or 3 or 4: |
---

>```$ jps``` (to verify running Hadoop Daemons)

Now Check your Word count program result at 

>```$ localhost:50070``` (output folder)

Thats it :)
