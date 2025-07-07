#!/bin/bash

LOGFILE="/home/ec2-user/nodejs-aws-codedeploy-pipeline/deploy.log"

echo "🔧 Running after_install.sh..." >> $LOGFILE

echo "📁 Changing directory to /home/ec2-user/nodejs-aws-codedeploy-pipeline" >> $LOGFILE
cd /home/ec2-user/nodejs-aws-codedeploy-pipeline || {
  echo "❌ Directory not found!" >> $LOGFILE
  exit 1
}

# Install Node.js and npm if not available
if ! command -v npm &> /dev/null; then
  echo "📦 Installing Node.js and npm..." >> $LOGFILE
  curl -sL https://rpm.nodesource.com/setup_18.x | bash - >> $LOGFILE 2>&1
  yum install -y nodejs >> $LOGFILE 2>&1
else
  echo "✅ npm already installed" >> $LOGFILE
fi

# Install app dependencies
echo "📦 Running npm install..." >> $LOGFILE
npm install >> $LOGFILE 2>&1

if [ $? -ne 0 ]; then
  echo "❌ npm install failed!" >> $LOGFILE
  exit 1
else
  echo "✅ npm install succeeded." >> $LOGFILE
fi
