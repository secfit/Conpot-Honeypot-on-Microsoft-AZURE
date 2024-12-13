#!/bin/sh


# Install mandatory packages
yum install gcc openssl-devel bzip2-devel libffi-devel zlib-devel libsqlite3-dev libbz2-dev build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget

# Install Python 3.9
cd /opt
wget https://www.python.org/ftp/python/3.9.6/Python-3.9.6.tgz
tar -xvf Python-3.9.6.tgz
./configure --enable-optimizations
make
make altinstall

# Install dependencies 
pip3.9 install db-sqlite3
pip3.9 install wheel
pip3.9 install pysqlite3
pip3.9 install urllib3==1.26.6
pip3.9 install pysnmp==4.4.12
pip3.9 install pyasn1==0.4.8
pip3.9 install scapy==2.4.5

# Install conpot
pip3.9 install conpot

#  Recompile Python 3.9
./configure --enable-optimizations
make
make altinstall

#
useradd HoneyAgent1 
sed -i "s,;user = conpot,user = root,g" /usr/local/lib/python3.9/site-packages/conpot/testing.cfg
sed -i "s,;group = conpot,group = root,g" /usr/local/lib/python3.9/site-packages/conpot/testing.cfg
chown -R HoneyAgent1:HoneyAgent1 /usr/local/lib/python3.9/site-packages/conpot/
touch /usr/local/lib/python3.9/site-packages/conpot.log
chown HoneyAgent1:HoneyAgent1 /usr/local/lib/python3.9/site-packages/conpot.log

# run Conpot
su HoneyAgent1
/usr/local/bin/conpot -c /usr/local/lib/python3.9/site-packages/conpot/testing.cfg -t default -f &
