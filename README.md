Apache Hadoop 2.X.X and Apache Spark 0.8.0 Installation
==============

Apache Hadoop 2.X.X installation...

Steps to be done before running setup.sh

>``` Install Open ssh Server```
---
>      sudo apt-get install openssh-server

>``` Install Oracle Java Jdk 1.6 or 1.7```
---
>      install Oracle Java 7
>      sudo add-apt-repository ppa:webupd8team/java
>      sudo apt-get update
>      sudo apt-get install oracle-java7-installer 

>``` Set JAVA_HOME in .bashrc```

>``` Steps for Hadoop Installation```
---
>      $ sh setup.sh $USER

>      1. Hadoop 2.2.0

>      2. Hadoop 2.3.0

>      3. Apache Spark 0.8.0

>      select required option 1 or 2 or 3 : |
---


Now Check your Word count program result at 

>```$ localhost:50070``` (output folder)

Thats it :)
