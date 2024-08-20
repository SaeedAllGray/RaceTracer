import asyncio
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from roslibpy import Ros, Topic
from urllib.parse import unquote
from .ros_service import RosService
from .models import ROSMessage
import subprocess
import time
import threading
import subprocess
import os
import json
import roslibpy
import time

ros_service = RosService()


def get_ros_nodes(request):
    try:
        nodes = ros_service.get_nodes()
        return JsonResponse({'nodes': nodes})
    except Exception as e:
        return JsonResponse({'error': str(e)})

def get_ros_node_info(request,node_name):
    try:
        node_info = ros_service.get_node_info(f'/{node_name}')
        return JsonResponse({'nodes_info': node_info})
    except Exception as e:
            return JsonResponse({'error': str(e)})

def get_ros_nodes_info(request):
    try:
        nodes_info = ros_service.get_nodes_info()
        return JsonResponse({'nodes_info': nodes_info})
    except Exception as e:
            return JsonResponse({'error': str(e)})


def get_ros_topics(request):
    try:
        topics = ros_service.get_topics()
        return JsonResponse({'topics': topics})
    except Exception as e:
        return JsonResponse({'error': str(e)})
    
def get_ros_topic_info(request,topic):
    try:
        topics = ros_service.get_topics()
        return JsonResponse({'topics': topics})
    except Exception as e:
        return JsonResponse({'error': str(e)})

def get_ros_topics_info(request):
    try:
        topics_info = ros_service.get_topics_info()
        return JsonResponse({'topics_info': topics_info})
    except Exception as e:
            return JsonResponse({'error': str(e)})
    
@csrf_exempt
def start_ros_node(request):
    try:
        node_name = request.POST.get('node_name')
        package_name = request.POST.get('package_name')
        command = f"rosrun {package_name} {node_name}"
        subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        return JsonResponse({"status": "success", "message": f"Started ROS node: {node_name}"})
    except Exception as e:
        return JsonResponse({"status": "error", "message": str(e)})

@csrf_exempt
def stop_ros_node(request):
    try:
        node_name = request.POST.get('node_name')
        command = f"rosnode kill {node_name}"
        subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        return JsonResponse({"status": "success", "message": f"Stopped ROS node: {node_name}"})
    except Exception as e:
        return JsonResponse({"status": "error", "message": str(e)})


@csrf_exempt
def get_message(request):
    try:
        encoded_topic_name = request.GET.get('topic')
        if not encoded_topic_name:
            return JsonResponse({'error': 'No topic specified'}, status=400)

        topic_name = unquote(encoded_topic_name)
        topic_type = ros_service.get_topic_info(topic_name)
        print(topic_type)
        ros_service.subscribe_to_topic(topic_name, topic_type)
        # Wait or check for the message; might need to handle this asynchronously
        time.sleep(1)  # Adjust timing as needed or use async handling
        message = ros_service.get_message()

        if message:
            return JsonResponse({"status": "success", "message": message})
        else:
            return JsonResponse({"status": "error", "message": "No message received"}, status=500)
    except Exception as e:
        return JsonResponse({"status": "error", "message": str(e)})



def get_ros_message22(request):
    encoded_topic = request.GET.get('topic')
    
    if not encoded_topic:
        return JsonResponse({"error": "Topic not provided"}, status=400)

    # Decode the topic name
    topic = unquote(encoded_topic)            

    try:
        # Source the environment
        source_command = 'source /home/getracing/Desktop/get/jarvic-mono/environment.sh && env'
        process = subprocess.Popen(source_command, stdout=subprocess.PIPE, shell=True, executable='/bin/bash')
        env_output, _ = process.communicate()

        # Extract environment variables
        env_vars = dict(line.split('=', 1) for line in env_output.decode('utf-8').splitlines() if '=' in line)

        # Create a ROS client
        ros = roslibpy.Ros(host='localhost', port=9091)
        ros.run()
        

        # Create a topic listener
        type = ros_service.get_topic_info(topic)
        listener = roslibpy.Topic(ros, topic, type)

        # Function to handle incoming messages
        def on_message(message):
            print(message)
            ros.terminate()
            return JsonResponse({"topic": topic, "message": message})

        listener.subscribe(on_message)

        # Wait until a message is received or timeout (you might want to add a timeout handler)
        ros.spin()

    except Exception as e:
        return JsonResponse({"error": f"Failed to retrieve message: {str(e)}"}, status=500)
    


def get_ros_message11(request):
    # Get the encoded topic from the request
    encoded_topic = request.GET.get('topic')
    
    if not encoded_topic:
        return JsonResponse({"error": "Topic not provided"}, status=400)

    # Decode the topic name from URL encoding
    topic = unquote(encoded_topic)
    
    try:
       
        ros_service.subscribe_to_topic(topic)
        message = ros_service.message()
        # if client.is_connected:
        #     print('Connected to ROS Bridge!')

     
        return JsonResponse({"topic": topic, "message": message})

    except Exception as e:
        return JsonResponse({"error": f"Failed to connect to ROS: {str(e)}"}, status=500)
# def start_services(request):
#     try:
#         services = [
#             ("roscore", "roscore", 3),
#             ("roslaunch rosbridge_server rosbridge_websocket.launch port:=9091", "rosbridge", 3),
#             ("rosrun turtlesim turtlesim_node", "turtlesim", 3),
#             ("roslaunch my_key_teleop key_teleop.launch", "key_teleop", 3),
#         ]

#         for command, log_name, sleep_time in services:
#             ros_service.start_service(command, log_name, sleep_time)

#         ros_thread = threading.Thread(target=ros_service.run())
#         ros_thread.start()
#         return JsonResponse({"status": "success", "message": "Roscore, rosbridge, turtle and teleop started"})
#     except Exception as e:
#         return JsonResponse({"status": "error", "message": str(e)})
    
# def get_ros_nodes(request):
#     try:
#         command = "rosnode list"
#         output = subprocess.check_output(command, shell=True, text=True)
#         nodes = output.splitlines()
#         return JsonResponse({"nodes": nodes})
#     except Exception as e:
#         return JsonResponse({"status": "error", "message": str(e)})


# def get_ros_topics2(request):
#     try:
#         command = "rostopic list"
#         output = subprocess.check_output(command, shell=True, text=True)
#         topics = output.splitlines()
#         return JsonResponse({"topics": topics})
#     except Exception as e:
#         return JsonResponse({"status": "error", "message": str(e)})

# def get_node_info(request, node_name):
    # try:
    #     command = f"rosnode info {node_name}"
    #     output = subprocess.check_output(command, shell=True, text=True)
    #     lines = output.splitlines()

    #     node_info = {
    #         "node": "",
    #         "publications": [],
    #         "subscriptions": [],
    #         "services": [],
    #         "pid": "",
    #         "connections": []
    #     }

    #     current_section = None
    #     for line in lines:
    #         if line.startswith("Node "):
    #             node_info["node"] = line.split("[")[1].split("]")[0]
    #         elif line.startswith("Publications:"):
    #             current_section = "publications"
    #         elif line.startswith("Subscriptions:"):
    #             current_section = "subscriptions"
    #         elif line.startswith("Services:"):
    #             current_section = "services"
    #         elif line.startswith("Pid:"):
    #             node_info["pid"] = line.split(": ")[1]
    #         elif line.startswith("Connections:"):
    #             current_section = "connections"
    #         elif line.startswith("* "):
    #             if current_section == "publications" or current_section == "subscriptions":
    #                 topic, msg_type = line.split(" [")
    #                 topic = topic.split("* ")[1]
    #                 msg_type = msg_type.rstrip("]")
    #                 node_info[current_section].append({"topic": topic, "type": msg_type})
    #             elif current_section == "services":
    #                 node_info[current_section].append(line.split("* ")[1])
    #         elif line.startswith(" * topic: "):
    #             connection_info = {"topic": line.split(": ")[1], "details": {}}
    #             node_info["connections"].append(connection_info)
    #         elif " * to: " in line:
    #             node_info["connections"][-1]["details"]["to"] = line.split(": ")[1]
    #         elif " * direction: " in line:
    #             node_info["connections"][-1]["details"]["direction"] = line.split(": ")[1]
    #         elif " * transport: " in line:
    #             node_info["connections"][-1]["details"]["transport"] = line.split(": ")[1]

    #     return JsonResponse(node_info)

    # except subprocess.CalledProcessError as e:
    #     return JsonResponse({"error": str(e)}, status=500)
       
def get_topic_info(request, topic_name):
    try:
        quoted_topic_name = subprocess.list2cmdline([topic_name])
        command = f"rostopic info {quoted_topic_name}"
        output = subprocess.check_output(command, shell=True, text=True)
        lines = output.splitlines()
        topic_type = None
        publishers = []
        subscribers = []

        section = None
        for line in lines:
            line = line.strip()
            if line.startswith("Type:"):
                topic_type = line.split("Type:")[1].strip()
            elif line.startswith("Publishers:"):
                section = "publishers"
            elif line.startswith("Subscribers:"):
                section = "subscribers"
            elif line.startswith("*"):
                node = line.split("*")[1].strip().split(" ")[0]
                if section == "publishers":
                    publishers.append(node)
                elif section == "subscribers":
                    subscribers.append(node)

        response_data = {
            "type": topic_type,
            "subscribers": subscribers,
            "publishers": publishers,
        }

    except subprocess.CalledProcessError as e:
        return JsonResponse({"error": f"An error occurred: {e}"}, status=400)
    
    return JsonResponse(response_data)


@csrf_exempt
def start_rosbag_recording(request):
    try:
        if request.method == 'POST':
            print(f"Request body: {request.body.decode('utf-8')}")
            print(f"POST data: {request.POST}")
        topics = request.POST.get('topics')
        print(topics)
        # if topics is None:
        #     return JsonResponse({"status": "error", "message": "No topics provided"})

        topics = json.loads(topics)
       
        if not isinstance(topics, list):
            return JsonResponse({"status": "error", "message": "Topics should be a list"})
        
        topics_str = ' '.join(topics)
        bag_name = request.POST.get('bag_name', 'default')
        rosbag_directory = "/home/saeed/Desktop/Projects/recordings/"
        os.makedirs(rosbag_directory, exist_ok=True)

        command = f"rosbag record -O {rosbag_directory}{bag_name} {topics_str}"
        
        process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        
        # Return a success response
        return JsonResponse({"status": "success", "message": f"Recording topics: {topics}"})
    except Exception as e:
        # Return an error response if an exception occurs
        print(str(e))
        return JsonResponse({"status": "error", "message": str(e)})

@csrf_exempt
def stop_rosbag_recording(request):
    try:
        command = "pkill -f 'rosbag record'"
        subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        return JsonResponse({"status": "success", "message": "Stopped rosbag recording"})
    except Exception as e:
        return JsonResponse({"status": "error", "message": str(e)})
    
@csrf_exempt
def get_rosbag_info(request,bag_name):
    try:
        command = f"rosbag info {bag_name}"
        subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        return JsonResponse({"status": "success", "message": "Stopped rosbag recording"})
    except Exception as e:
        return JsonResponse({"status": "error", "message": str(e)})
    



def start_roscore(request): # TODO: it has errors, maybe I should run rosbridge here as well 
    try:
        command = "roscore"
        subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        return JsonResponse({"status": "success", "message": "done"})
    except Exception as e:
        return JsonResponse({"status": "error", "message": str(e)})
    





