#!/bin/bash

sudo apt-get update -y

sudo apt-get install -y apache2

sudo systemctl start apache2
sudo systemctl enable apache2

echo "<h1>Hello from Terraform!</h1><p>Task 4 is Complete.</p>" | sudo tee /var/www/html/index.html