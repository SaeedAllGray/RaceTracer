import roslibpy
from pathlib import Path
import subprocess
import time

class RosService:
    def __init__(self):
        self.ros = roslibpy.Ros(host='localhost', port=9091)
        self.LOG_DIR = Path.home() / 'Desktop/Projects/logs'
        self.LOG_DIR.mkdir(parents=True, exist_ok=True)
        self.ros.on_ready(self.on_ready)
        self.ros.run()  # Ensure you call run after setting up the on_ready callback
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
    
    def get_topic_info(self, topic):
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

    def subscribe_to_topic(self, topic_name, msg_type):
        if self.subscriber:
            self.subscriber.unsubscribe()  # Unsubscribe from previous topic
        self.subscriber = roslibpy.Topic(self.ros, topic_name, msg_type)
        self.subscriber.subscribe(self.callback)

    def callback(self, message):
        self.message = message

    def get_message(self):
        return self.message
