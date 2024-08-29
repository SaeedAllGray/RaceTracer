from django.http import JsonResponse
from django.shortcuts import render
from .git_service import GitService
from .parser import Parser 
import subprocess
from racetracer.utils import git_config, general


project_directory = git_config.get('project_directory') 
track_files = git_config.get('track_files')

git_service = GitService(project_directory)

# config_path = os.path.join('/race-tracer/config.yaml')

# # Load the YAML file
# with open(config_path, 'r') as file:
#     CONFIG = yaml.safe_load(file)

# git_service = GitService(CONFIG["git"]["project_directory"])

def set_configurations(request):
    try:
        return JsonResponse({'status': 'success','message' :general})
    except Exception as e:
        return JsonResponse({"status": "error", "message": str(e)})
def git_add(request):
    try:
        git_service.git_add()
        return JsonResponse({'status': 'success', 'message': 'Added all files to staging area'})
    except Exception as e:
        return JsonResponse({"status": "error", "message": str(e)})
def git_commit(request):
    try:
        commit_message = request.POST.get('message', 'Default commit message')
        git_service.git_commit(commit_message)
        return JsonResponse({'status': 'success', 'message': f'Committed with message: {commit_message}'})
    except Exception as e:
        return JsonResponse({"status": "error", "message": str(e)})
    
def git_diff(request):
    try:
        diff = git_service.git_diff(track_files)

        return JsonResponse({'status': 'success', 'diff': diff })
    except Exception as e:
        return JsonResponse({"status": "error", "message": str(e)})

def git_push(request):
    try:
        diff = git_service.git_push()
        return JsonResponse({'status': 'success', 'diff': "Pushed sucessfully" })
    except Exception as e:
        return JsonResponse({"status": "error", "message": str(e)})
    
def git_add_commit_push(request):
    try:
        message = request.GET.get('message')
        git_service.switchBranch()
        git_service.git_add()
        print(message)
    
        commit=git_service.git_commit(message)
        
        print(commit.hexsha)
        git_service.git_push()
        return JsonResponse({'status': 'success', 'hexsha': commit.hexsha})
    except Exception as e:
        print(str(e))
        return JsonResponse({"status": "error", "message": str(e)})
    
