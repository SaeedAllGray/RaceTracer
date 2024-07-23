from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from roslibpy import Ros, Topic
from .ros_service import RosService
from .git_service import GitService
from .parser import Parser
import subprocess
import time
import subprocess
import os
import json


ros_service = RosService()
git_service = GitService('/home/saeed/catkin_ws/src/my_key_teleop/')


def git_add(request):
    git_service.git_add()
    return JsonResponse({'status': 'success', 'message': 'Added all files to staging area'})

def git_commit(request):
    commit_message = request.POST.get('message', 'Default commit message')
    git_service.git_commit(commit_message)
    return JsonResponse({'status': 'success', 'message': f'Committed with message: {commit_message}'})

def git_diff(request):
    diff = git_service.git_diff()
    diff_json = Parser().parse_diff_to_json(diff)
    return JsonResponse({'status': 'success', 'diff': diff_json })

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
    





