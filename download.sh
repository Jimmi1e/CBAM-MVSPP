#!/bin/bash

#SBATCH --job-name=downloadDtuDataset       ## Give the job a name
#SBATCH --time=10:00:00
#SBATCH --account=def-xinxin
#SBATCH --mail-type=ALL        ## Receive all email type notifications
#SBATCH --mail-user=yuhangchen0425@gmail.com
#SBATCH -o output-%A.log
#SBATCH --chdir=./             ## Use currect directory as working directory

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1      ## Request 1 cpus
#SBATCH --mem=50G               ## Assign 1G memory per node

echo "Downloading DTU dataset..."
echo "=============================" 
sleep 30
date 
echo "Downloading DTU training data..."
wget -c https://polybox.ethz.ch/index.php/s/ugDdJQIuZTk4S35/download/dtu.tar.xz -O dtu.tar.xz

echo "Downloading Rectified.zip..."
wget -c http://roboimagedata2.compute.dtu.dk/data/MVS/Rectified.zip -O Rectified.zip


echo "Extracting downloaded files..."
tar -xf dtu.tar.xz
unzip -o Rectified.zip
date
echo "Finished"