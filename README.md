# Conpot-Honeypot-on-Microsoft-AZURE
Create Industrial Control System in cloud environment : Microsoft AZURE case


*Conpot* is an open-source industrial control system (ICS) honeypot designed to mimic industrial devices like PLCs, HMI, and SCADA systems. <br>
It helps cybersecurity professionals study attacks and identify potential threats targeting ICS environments.<br>

#### The role of Conpot in ICS:
-  Threat Detection
-  Incident Response
-  Training and Research
-  Enhancing Security
<br><br>

### This repository is dedicated to automating the installation of Conpot in a cloud environment and exploring its key features for detecting malicious behavior in industrial control systems (ICS).

## Step 1:
Install Linux Virtual Machine on Microsoft AZURE using API REST.<br>
Follow the detailed installation process provided in this repository : [VM-on-Microsoft-AZURE-by-REST-API](https://github.com/secfit/VM-on-Microsoft-AZURE-by-REST-API)

## Step 2:
Once you install Linux server into Microsoft AZURE, connect as `root` user to the server via SSH protocol.<br>

<b>[You can pursue the following steps or download conpot installation script from : [conpot_install.sh](conpot_install.sh)]</b>
<br>
1.  Install mandatory packages and libraries :
   ```shell
    yum install gcc openssl-devel bzip2-devel libffi-devel zlib-devel libsqlite3-dev libbz2-dev build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget
   ```

<br>2.  Install and compile Python 3.9 :
   ```shell
    cd /opt
    wget https://www.python.org/ftp/python/3.9.6/Python-3.9.6.tgz
    tar -xvf Python-3.9.6.tgz
    cd Python-3.9.6
    ./configure --enable-optimizations
    make
    make altinstall
   ```

<br>3.  Install Conpot’s Python dependencies `pip3.9`:
   ```shell
    pip3.9 install db-sqlite3
    pip3.9 install wheel
    pip3.9 install pysqlite3
    pip3.9 install urllib3==1.26.6
    pip3.9 install pysnmp==4.4.12
    pip3.9 install pyasn1==0.4.8
    pip3.9 install scapy==2.4.5
   ```

<br>4.  Install Conpot :
   ```shell
    pip3.9 install conpot
   ```

<br>5.  Recompile last installed Python 3.9:<br>
    (Note : Important step to recompile python 3.9 with the last installed dependencies )<br>
   ```shell
    ./configure --enable-optimizations
    make
    make altinstall
   ```

<br>6.  Create Conpot User :
   ```shell
    useradd HoneyAgent1 
   ```

<br>7.  Change Conpot configuration :
   ```shell
    sed -i "s,;user = conpot,user = root,g" /usr/local/lib/python3.9/site-packages/conpot/testing.cfg
    sed -i "s,;group = conpot,group = root,g" /usr/local/lib/python3.9/site-packages/conpot/testing.cfg 
   ```

<br>8.  Grant privileges to the last created user `HoneyAgent1` :
   ```shell
    sed -i "s,;user = conpot,user = root,g" /usr/local/lib/python3.9/site-packages/conpot/testing.cfg
    sed -i "s,;group = conpot,group = root,g" /usr/local/lib/python3.9/site-packages/conpot/testing.cfg
    touch /usr/local/lib/python3.9/site-packages/conpot.log
    chown HoneyAgent1:HoneyAgent1 /usr/local/lib/python3.9/site-packages/conpot.log
   ```

<br>9.  change user to `HoneyAgent1` :
   ```shell
    su HoneyAgent1
   ```

<br>10.  Run Conpot service in Background :
   ```shell
    /usr/local/bin/conpot -c /usr/local/lib/python3.9/site-packages/conpot/testing.cfg -t default -f &
   ```

<br>11.  Ensure the Conpot service runned correctly on system :<br>
    (Note : You will find that the default Conpot ports are open [8800, 10201, 5020, 2121, 44818] )<br>
   ```shell
    netstat -tupln
   ```
   ![conpot_running_service](conpot_running_service.jpeg)
