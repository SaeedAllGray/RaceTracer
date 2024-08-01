from roslibpy import Ros, Topic
from django.http import JsonResponse
import roslibpy
import os
import threading
import time
import subprocess
from pathlib import Path


class RosService:
    
    def __init__(self):
        self.ros = Ros(host='localhost', port=9091)
        self.LOG_DIR = Path.home() / 'Desktop/Projects/logs'
        self.LOG_DIR.mkdir(parents=True, exist_ok=True)
        self.ros.run()

        self.turtle_commander = roslibpy.Topic(self.ros, '/turtle1/cmd_vel', 'geometry_msgs/Twist')

    # def run(self):
    #     self.ros.run()

    def start_service(self,command, log_name, sleep_time):
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
    
    def get_topic_info(self,topic):
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
        self.client.terminate()
    # def get_ros_nodes(self,request):
    #     try:
    #         nodes = self.ros.get_nodes()
    #         return JsonResponse({'nodes': nodes})
    #     except Exception as e:
    #         return JsonResponse({'error': str(e)})
          
    
       
        
    
        

    def publish_message(self, topic_name, message):
        talker = roslibpy.Topic(self.ros, topic_name, 'std_msgs/String')
        talker.publish(roslibpy.Message({'data': message}))
        talker.unadvertise()

    def subscribe_to_topic(self, topic_name, callback):
        listener = roslibpy.Topic(self.ros, topic_name, 'std_msgs/String')
        listener.subscribe(callback)

        self.turtle_commander = roslibpy.Topic(
            self.client, '/turtle1/cmd_vel', 'geometry_msgs/Twist')

    def move_turtle(self, linear, angular):
        twist = roslibpy.Message({
            'linear': {
                'x': linear,
                'y': 0.0,
                'z': 0.0
            },
            'angular': {
                'x': 0.0,
                'y': 0.0,
                'z': angular
            }
        })
        self.turtle_commander.publish(twist)

    def shutdown(self):
        self.ros.terminate()
        