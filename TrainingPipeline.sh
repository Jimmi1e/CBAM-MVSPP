#!/bin/bash

#SBATCH --job-name=Training
#SBATCH --mail-type=ALL
#SBATCH --mail-user=yuhangchen0425@gmail.com
#SBATCH --chdir=./
#SBATCH -o output-%A.log

# Request Resources
#SBATCH --mem=60G
#SBATCH --nodes=1
#SBATCH -n 16
#SBATCH --time=1-24:00:00
#SBATCH --gres=gpu:a100:2

# Load required modules
module load python/3.11
module load StdEnv/2023
module load gcc/12.3
mudule load cuda/12.2
module load opencv/4.9.0


# Define environment name and path 
ENV_NAME="project_envpp"

ENV_DIR=/home/$USER/projects/def-xinxin/$USER/"

ENV_PATH = "$ENV_DIR/$ENV_NAME"

# Check if the environment exists
if [ -d "$ENV_PATH" ]; then
    echo "Environment $ENV_NAME already exists. Activating it..."
    echo "======================================================"
    source "$ENV_PATH/bin/activate"
else
    echo "Creating environment $ENV_NAME at $ENV_PATH..."
    echo "===================================================="
    virtualenv "$ENV_PATH"

    echo "Activating environment $ENV_NAME..."
    echo "==================================="
    source "$ENV_PATH/bin/activate"
    pip install --no-index -r requirements.txt
fi

echo "Environment summary..."
echo "============================"
pip list

sleep 30

# Training on DTU's data set

echo "Running Training processing..."
echo "================================================"
python train.py --config config/mvsformer++.json --exp_name MVSFormer++ --DDP
deactivate
exit 0