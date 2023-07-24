#!/bin/bash

clear 
printf "Preparing system...\n" 
sleep 3 
clear 
printf "Updating system...\n" 
sleep 3 
sudo apt -q update && sudo apt upgrade -y  
sleep 3
clear 
printf "installing packages needed for main install\n" 
sleep 3 
sudo apt -q install nala python3 python3-pip  
pip install tqdm
clear 
printf "Required packages successfully installed\n" 
sleep 3 
clear 
printf "Beginning main install\n" 
sleep 3 
clear 

./base_programs
./main_programs
