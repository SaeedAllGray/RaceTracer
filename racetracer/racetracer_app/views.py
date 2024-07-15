from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import subprocess
import time
import os
import paramiko

SSH_HOST = '192.168.64.3'
SSH_PORT = 22
SSH_USER = 'saeed'
SSH_PASSWORD = '1'  # It's better to use SSH keys for authentication

def ssh_execute_command(command):
    try:
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh.connect(SSH_HOST, port=SSH_PORT, username=SSH_USER, password=SSH_PASSWORD)
        
        # Ensure roscore is running and then execute the command
        start_roscore_command = "source /opt/ros/noetic/setup.bash && roscore &"
        ssh.exec_command(start_roscore_command)
        
        # Wait for a short period to allow roscore to start (adjust as necessary)
        time.sleep(5)
        
        # Execute the desired command (rosrun in this case)
        full_command = f"source /opt/ros/noetic/setup.bash && {command}"
        stdin, stdout, stderr = ssh.exec_command(full_command)
        
        output = stdout.read().decode()
        error = stderr.read().decode()
        
        ssh.close()
        return output, error
    except Exception as e:
        return None, str(e)

@csrf_exempt
def start_ros_node(request):
    try:
        node_name = request.POST.get('node_name')
        package_name = request.POST.get('package_name')
        command = f"rosecore; rosrun {package_name} {node_name}"
        output, error = ssh_execute_command(command)
        if error:
            return JsonResponse({"status": "error", "message": error})
        return JsonResponse({"status": "success", "message": f"Started ROS node: {node_name}"})
    except Exception as e:
        return JsonResponse({"status": "error", "message": str(e)})
    # try:
    #     node_name = request.POST.get('node_name')
    #     package_name = request.POST.get('package_name')
    #     command = f"rosrun {package_name} {node_name}"
    #     subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    #     return JsonResponse({"status": "success", "message": f"Started ROS node: {node_name}"})
    # except Exception as e:
    #     return JsonResponse({"status": "error", "message": str(e)})

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
