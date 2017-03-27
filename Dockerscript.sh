#!/bin/bash
mkdir -p mysql 
mkdir -p nginx/config
mkdir -p wordpress 
mkdir -p phpfpm/config 
mkdir -p phpfpm/app
mv Dockerfile1 mysql/Dockerfile
mv Dockerfile2 wordpress/Dockerfile
mv Dockerfile3 nginx/Dockerfile
mv Dockerfile4 phpfpm/Dockerfile
mv run.sh2 wordpress/run.sh
mv run.sh4 phpfpm/run.sh
mv default.conf nginx/config/default.conf
mv nginx.conf nginx/config/nginx.conf
mv startdb.sh mysql/startdb.sh
mv php-fpm.conf phpfpm/config/php-fpm.conf
mv www.conf phpfpm/config/www.conf
cd mysql 
docker build -t mysql .
cd ..
cd wordpress
docker build -t wordpress .
cd ..
cd phpfpm
docker build -t phpfpm .
cd ..
cd nginx
docker build -t nginx .
cd ..
docker run -d --name mysql1 mysql
docker run -i -t --name wordpress1 wordpress
docker run -d --name app1 --volumes-from wordpress1 --link mysql1:db phpfpm
docker run -d -p 8023:80 --name nginx1 --volumes-from wordpress1 --link app1:app1 nginx

