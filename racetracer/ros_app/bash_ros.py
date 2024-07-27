import os
import time
import subprocess
from pathlib import Path

LOG_DIR = Path.home() / 'Desktop/Projects/logs'
LOG_DIR.mkdir(parents=True, exist_ok=True)

def start_service(command, log_name, sleep_time):
    log_path = LOG_DIR / f'{log_name}.log'
    with open(log_path, 'w') as log_file:
        process = subprocess.Popen(command, shell=True, stdout=log_file, stderr=log_file)
    time.sleep(sleep_time)
    return process

def run_services():
    services = [
        ("roscore", "roscore", 5),
        ("roslaunch rosbridge_server rosbridge_websocket.launch port:=9091", "rosbridge", 5),
        ("rosrun turtlesim turtlesim_node", "turtlesim", 5),
        ("roslaunch my_key_teleop key_teleop.launch", "key_teleop", 5),
    ]

    for command, log_name, sleep_time in services:
        start_service(command, log_name, sleep_time)
