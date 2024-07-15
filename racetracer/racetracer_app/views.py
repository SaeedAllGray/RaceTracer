from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import subprocess
import os

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


def get_ros_nodes(request):
    try:
        command = "rosnode list"
        output = subprocess.check_output(command, shell=True, text=True)
        nodes = output.splitlines()
        return JsonResponse({"nodes": nodes})
    except Exception as e:
        return JsonResponse({"status": "error", "message": str(e)})


def get_ros_topics(request):
    try:
        command = "rostopic list"
        output = subprocess.check_output(command, shell=True, text=True)
        topics = output.splitlines()
        return JsonResponse({"topics": topics})
    except Exception as e:
        return JsonResponse({"status": "error", "message": str(e)})

def get_topic_info(request, topic_name):
    command = f"rostopic info {topic_name}"
    try:
        output = subprocess.check_output(command, shell=True, text=True)
        # Split the output by newline to create a list
        topic_info = output.splitlines()
    except subprocess.CalledProcessError as e:
        return JsonResponse({"error": f"An error occurred: {e}"}, status=400)
    
    return JsonResponse({"topic_info": topic_info})

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
