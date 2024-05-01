#!/bin/bash

# Exit script if any command fails
set -e

# 3.1.1 Install Java
echo "Installing Java..."
sudo apt install -y openjdk-8-jre-headless

# Append Java environment variables to .bashrc
echo "Configuring Java environment variables..."
{
    echo 'JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64'
    echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64'
    echo 'export JRE_HOME=$JAVA_HOME/jre'
    echo 'export PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin'
} >> ~/.bashrc

# Apply the environment variables
source ~/.bashrc

# 3.1.2 Install API-transport-https package
echo "Installing apt-transport-https..."
sudo apt install -y apt-transport-https

# Verify Java installation
echo "Verifying Java installation..."
java -version

# 3.2 Install Cassandra
echo "Installing Cassandra..."

# Add the Apache Cassandra repository
echo "Adding the Apache Cassandra repository..."
echo "deb [signed-by=/etc/apt/keyrings/apache-cassandra.asc] https://debian.cassandra.apache.org 41x main" | sudo tee /etc/apt/sources.list.d/cassandra.sources.list

# Ensure the /etc/apt/keyrings directory exists
sudo mkdir -p /etc/apt/keyrings

# Add the Apache Cassandra repository keys
echo "Adding the Apache Cassandra repository keys..."
curl -fsSL https://downloads.apache.org/cassandra/KEYS | sudo tee /etc/apt/keyrings/apache-cassandra.asc > /dev/null

# Update the package index
echo "Updating the package index..."
sudo apt-get update

# 3.2.4 Install Cassandra
sudo apt-get install -y cassandra

echo "Cassandra installation completed."
