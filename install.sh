#!/bin/bash

clear 
printf "Preparing system...\n" 
sleep 3 
clear 
printf "Updating system...\n" 
sleep 3 
sudo apt -qq update && sudo apt upgrade -y > /dev/null 2>&1 
sleep 3
clear 
printf "installing packages needed for main install\n" 
sleep 3 
sudo apt -qq install nala python3 python3-pip > /dev/null 2>&1 
clear 
printf "Required packages successfully installed\n" 
sleep 3 
clear 
printf "Beginning main install\n" 
sleep 3 
clear 

./base_programs
./main_programs
