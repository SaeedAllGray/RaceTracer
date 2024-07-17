from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from roslibpy import Ros, Topic
from .ros_service import RosService
import subprocess
import time
import os

service = RosService()


def get_ros_nodes(request):
    try:
        nodes = service.get_nodes()
        return JsonResponse({'nodes': nodes})
    except Exception as e:
        return JsonResponse({'error': str(e)})

def get_ros_node_info(request,node_name):
    try:
        node_info = service.get_node_info(f'/{node_name}')
        return JsonResponse({'nodes_info': node_info})
    except Exception as e:
            return JsonResponse({'error': str(e)})

def get_ros_nodes_info(request):
    try:
        nodes_info = service.get_nodes_info()
        return JsonResponse({'nodes_info': nodes_info})
    except Exception as e:
            return JsonResponse({'error': str(e)})


def get_ros_topics(request):
    service.get_ros_topics(request)

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


def get_ros_topics(request):
    try:
        command = "rostopic list"
        output = subprocess.check_output(command, shell=True, text=True)
        topics = output.splitlines()
        return JsonResponse({"topics": topics})
    except Exception as e:
        return JsonResponse({"status": "error", "message": str(e)})

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
        topics = request.POST.get('topics')
        bag_name = request.POST.get('bag_name', 'default')
        rosbag_directory = "/home/saeed/Desktop/Projects/recordings/"
        # Ensure the directory exists
        os.makedirs(rosbag_directory, exist_ok=True)


        command = f"rosbag record -O {rosbag_directory}{bag_name} {topics}"
        process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        # output, error = process.communicate()
        return JsonResponse({"status": "success", "message": f"{topics}"})
    except Exception as e:
        return JsonResponse({"status": "error", "message": str(e)})

@csrf_exempt
def stop_rosbag_recording(request):
    try:
        command = "pkill -f 'rosbag record'"
        subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        return JsonResponse({"status": "success", "message": "Stopped rosbag recording"})
    except Exception as e:
        return JsonResponse({"status": "error", "message": str(e)})
    

def start_roscore(request):
    try:
        command = "roscore"
        subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        return JsonResponse({"status": "success", "message": "done"})
    except Exception as e:
        return JsonResponse({"status": "error", "message": str(e)})