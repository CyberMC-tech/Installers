#!/usr/bin/env python3

import os
import subprocess
import time

from tqdm import tqdm

C1 = "wget https://github.com/cheat/cheat/releases/download/4.4.0/cheat-linux-amd64.gz"
C2 = "gunzip cheat-linux-amd64.gz"
C3 = "sudo chmod +x cheat-linux-amd64"
C4 = "sudo mv cheat-linux-amd64 /usr/local/bin/cheat"
C5 = "sudo rm -rf ./cheat-linux-amd64.gz"

COMMANDS = [C1, C2, C3, C4, C5]


def SPR(command):
    subprocess.run(
        command, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL
    )


t = tqdm(COMMANDS, colour="cyan", desc="Installing cheat")

os.system("clear")
print("Installing cheat...")
for i in t:
    SPR(i)
    time.sleep(0.5)
