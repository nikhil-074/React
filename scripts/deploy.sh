#!/bin/bash
echo "Deploying new React build..."
cp -r * /var/www/html/
chown -R www-data:www-data /var/www/html
systemctl restart nginx
echo "Deployment completed!"
