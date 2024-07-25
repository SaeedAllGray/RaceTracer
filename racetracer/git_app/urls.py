from django.urls import path
from . import views



urlpatterns = [
    path('add/', views.git_add, name='git add'),
    path('commit/', views.git_commit, name="git commit"),
    path('diff/', views.git_diff, name='git diff'),
    path('push/', views.git_push, name='git push'),
]