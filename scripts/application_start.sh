#!/bin/bash

LOGFILE="/home/ec2-user/nodejs-aws-codedeploy-pipeline/deploy.log"
APP_DIR="/home/ec2-user/nodejs-aws-codedeploy-pipeline"
APP_FILE="app.js" # Replace with index.js or server.js if needed
APP_NAME="nodejs-express-app"

echo "🚀 Running application_start.sh..." >> $LOGFILE

cd $APP_DIR || {
  echo "❌ Failed to change directory to $APP_DIR" >> $LOGFILE
  exit 1
}

# Ensure pm2 is installed
if ! command -v pm2 &> /dev/null; then
  echo "📦 Installing pm2 globally..." >> $LOGFILE
  npm install -g pm2 >> $LOGFILE 2>&1
fi

# Stop and delete old app if it exists
if pm2 list | grep -q "$APP_NAME"; then
  echo "🧹 Deleting existing PM2 app: $APP_NAME" >> $LOGFILE
  pm2 delete $APP_NAME >> $LOGFILE 2>&1
fi

# Start the app
echo "🚀 Starting $APP_FILE with pm2 --name $APP_NAME" >> $LOGFILE
pm2 start $APP_FILE --name $APP_NAME >> $LOGFILE 2>&1

# Save the process list
pm2 save >> $LOGFILE 2>&1
