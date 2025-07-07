#!/bin/bash

LOGFILE="/home/ec2-user/nodejs-aws-codedeploy-pipeline/deploy.log"

echo "🚀 Running application_start.sh..." >> $LOGFILE

cd /home/ec2-user/nodejs-aws-codedeploy-pipeline || {
  echo "❌ Failed to change directory" >> $LOGFILE
  exit 1
}

# Ensure pm2 is installed
if ! command -v pm2 &> /dev/null; then
  echo "📦 Installing pm2 globally..." >> $LOGFILE
  npm install -g pm2 >> $LOGFILE 2>&1
else
  echo "✅ pm2 already installed" >> $LOGFILE
fi

# Start the Node.js app
echo "🚀 Starting app using pm2..." >> $LOGFILE
pm2 start app.js --name node-app >> $LOGFILE 2>&1

# Save pm2 process list (optional, good for reboot persistence)
pm2 save >> $LOGFILE 2>&1
