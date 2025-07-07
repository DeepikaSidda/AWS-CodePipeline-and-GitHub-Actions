#!/bin/bash

echo 'run start.sh: ' >> /home/ec2-user/app/deploy.log

echo 'cd /home/ec2-user/app' >> /home/ec2-user/app/deploy.log
cd /home/ec2-user/app

echo 'pkill node (ignore if not running)' >> /home/ec2-user/app/deploy.log
pkill node >> /home/ec2-user/app/deploy.log 2>&1 || echo 'No node process found' >> /home/ec2-user/app/deploy.log

echo 'starting app with nohup npm start' >> /home/ec2-user/app/deploy.log
nohup npm start >> /home/ec2-user/app/app.log 2>&1 &

echo 'start.sh completed' >> /home/ec2-user/app/deploy.log
