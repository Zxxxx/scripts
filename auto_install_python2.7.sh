#!/bin/bash  
#  
#Author: darkmelody  
#自动安装Python2.7环境
#centos6.5测试通过


  
#安装依赖包#
yum -y install python-devel openssl-devel gcc gcc-c++ sqlite-devel readline-devel ncurses-devel bzip2-devel tk-devel

#下载python源码包# 
cd /tmp
version='2.7.13'
python_url="https://www.python.org/ftp/python/$version/Python-${version}.tgz"
wget $python_url


#########################编译安装python#  
tar zxvf Python-$version.tgz
cd Python-$version
./configure
make -j 4
make altinstall
sleep 5

#######################替换之前python#  
mv /usr/bin/python /usr/bin/python.bak  
ln -s /usr/local/bin/python2.7 /usr/bin/python

sed -i 's/#!\/usr\/bin\/python/#!\/usr\/bin\/python2.6/' /usr/bin/yum


#安装easy_install,pip,virtualenv

wget --no-check-certificate -c https://bootstrap.pypa.io/ez_setup.py && python ez_setup.py
/usr/local/bin/easy_install-2.7 pip
pip install virtualenv
