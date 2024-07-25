from django.http import JsonResponse
from django.shortcuts import render
from .git_service import GitService
from .parser import Parser
import subprocess


git_service = GitService('/home/saeed/catkin_ws/src/my_key_teleop/')


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
        diff = git_service.git_diff()
        diff_json = Parser().parse_diff_to_json(diff)
        return JsonResponse({'status': 'success', 'diff': diff_json })
    except Exception as e:
        return JsonResponse({"status": "error", "message": str(e)})

def git_push(request):
    try:
        diff = git_service.git_push()
        return JsonResponse({'status': 'success', 'diff': "Pushed sucessfully" })
    except Exception as e:
        return JsonResponse({"status": "error", "message": str(e)})