Apache Hadoop Installation
==============

Apache Hadoop installation...

Steps to be done before running setup.sh

>``` Install ssh Server```
---
>      $ sudo apt-get install ssh
>      $ ssh-keygen -t rsa -P ""
>      $ cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
>      $ ssh localhost
>      $ exit

>``` install Oracle Java 7```
---
>      sudo add-apt-repository ppa:webupd8team/java
>      sudo apt-get update
>      sudo apt-get install oracle-java7-installer 

>``` Set JAVA_HOME in .bashrc```

>``` Steps for Hadoop Installation```
---
>      $ sh setup.sh $USER

>      1. Hadoop 1.2.1

>      2. Hadoop 2.2.0

>      3. Hadoop 2.3.0

>      4. Hadoop 2.4.0

>      select required option 1 or 2 or 3 or 4: |
---


Now Check your Word count program result at 

>```$ localhost:50070``` (output folder)

Thats it :)
