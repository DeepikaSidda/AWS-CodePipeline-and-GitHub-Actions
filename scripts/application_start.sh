#!/bin/bash

echo 'Running application_start.sh...' >> /home/ec2-user/nodejs-aws-codedeploy-pipeline/deploy.log

cd /home/ec2-user/nodejs-aws-codedeploy-pipeline

# Ensure Node.js and npm are installed
if ! command -v node &> /dev/null
then
  curl -sL https://rpm.nodesource.com/setup_18.x | sudo bash -
  sudo yum install -y nodejs
fi

# Ensure pm2 is installed
if ! command -v pm2 &> /dev/null
then
  sudo npm install -g pm2
fi

# Delete existing PM2 process (ignore error if not found)
pm2 delete nodejs-express-app || true

# Start the app using PM2
pm2 start app.js --name nodejs-express-app >> deploy.log

# Save PM2 process list (so it restarts on reboot)
pm2 save >> deploy.log
