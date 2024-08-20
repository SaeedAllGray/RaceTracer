import os
import roslibpy
from pathlib import Path
import subprocess
import time

class RosService:
    def __init__(self):
        command = 'source /opt/ros/noetic/setup.bash'  # Adjust the path to your ROS setup file
    # Use subprocess to run the command in a shell
        proc = subprocess.Popen(['bash', '-c', command + ' && env'], stdout=subprocess.PIPE, executable='/bin/bash')
        output, _ = proc.communicate()


        # Update the current environment with the sourced environment variables
        for line in output.splitlines():
            key, _, value = line.partition(b"=")
            os.environ[key.decode("utf-8")] = value.decode("utf-8")
        self.ros = roslibpy.Ros(host='localhost', port=9091)
        self.LOG_DIR = Path.home() / 'Desktop/Projects/logs'
        self.LOG_DIR.mkdir(parents=True, exist_ok=True)
        self.ros.on_ready(self.on_ready)
        self.ros.run()  # Ensure you call run after setting up the on_ready callback

        if not self.ros.is_connected:
            print("Failed to connect to ROS bridge")
        else:
            print("Successfully connected to ROS bridge")
        self.message = None
        self.subscriber = None

    def start_service(self, command, log_name, sleep_time):
        log_path = self.LOG_DIR / f'{log_name}.log'
        with open(log_path, 'w') as log_file:
            process = subprocess.Popen(command, shell=True, stdout=log_file, stderr=log_file)
        time.sleep(sleep_time)
        return process

    def get_nodes(self):
        return self.ros.get_nodes()
    
    def get_node_info(self, node_name):
        return self.ros.get_node_details(node_name)
    
    def get_nodes_info(self):
        nodes_info = []
        nodes = self.get_nodes()
        for node_name in nodes:
            node_info = self.get_node_info(node_name)
            nodes_info.append({
                'node_name': node_name,
                'node_info': node_info
            })
        return nodes_info

    def get_topics(self):
        return self.ros.get_topics()
    
    def get_topic_info(self, topic) -> str:
        return self.ros.get_topic_type(topic)
    
    def get_topics_info(self):
        topics_info = []
        topics = self.get_topics()
        for topic_name in topics:
            topic_info = self.get_topic_info(topic_name)
            topics_info.append({
                'topic': topic_name,
                'type': topic_info
            })
        return topics_info

    def shutdown(self):
        self.ros.terminate()

    def on_ready(self):
        print("ROS is ready")
        # Initialize other aspects of your ROS setup here

    def subscribe_to_topic(self, topic_name):
        type = self.ros.get_topic_type(topic_name)
        print(f"Topic type of {topic_name}: {type}")

        if not type:
            print(f"Failed to get type for topic {topic_name}")
            return

        if self.subscriber:
            self.subscriber.unsubscribe()
            print(f"Unsubscribed from previous topic")

        self.subscriber = roslibpy.Topic(self.ros, topic_name, type)
        print(f"Subscribing to topic {topic_name} with type {type}")
        time.sleep(1)

        self.subscriber.subscribe(self.callback)
        time.sleep(1)
        print('Subscription completed')

    def callback(self, message):
        print('Received message:', message)
        self.message = message



