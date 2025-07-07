#!/bin/bash

echo 'run after_install.sh: ' >> /home/ec2-user/app/deploy.log

echo 'cd /home/ec2-user/app' >> /home/ec2-user/app/deploy.log
cd /home/ec2-user/app

echo 'npm install' >> /home/ec2-user/app/deploy.log 
npm install >> /home/ec2-user/app/deploy.log 2>&1
