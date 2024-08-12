from django.http import JsonResponse
from django.shortcuts import render
from .git_service import GitService
from .parser import Parser
import subprocess


git_service = GitService('/home/getracing/Desktop/jarvic-mono/')


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
        diff = git_service.git_diff()
        git_service.switchBranch()
        git_service.git_add()
        print(message)
        commit_message = f"RaceTracer: {message}"
        git_service.git_commit(commit_message)
        git_service.git_push()
        return JsonResponse({'status': 'success', 'diff': diff})
    except Exception as e:
        print(str(e))
        return JsonResponse({"status": "error", "message": str(e)})