from django.urls import path
from . import views



urlpatterns = [
    
    path('diff/', views.git_diff, name='git diff'),
    path('push/', views.git_add_commit_push, name='git push'),
    path('setup/', views.set_configurations,name='setup'),
]