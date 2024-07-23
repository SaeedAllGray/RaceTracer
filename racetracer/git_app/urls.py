from django.urls import path
from . import views



urlpatterns = [
    path('add/', views.git_add, name='git add'),
    path('diff/', views.git_diff, name='git diff'),
]