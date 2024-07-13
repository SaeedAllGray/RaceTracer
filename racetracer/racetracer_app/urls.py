from django.urls import path
from . import views

urlpatterns = [
    path('start_ros_node/', views.start_ros_node, name='start_ros_node'),
    path('stop_ros_node/', views.stop_ros_node, name='stop_ros_node'),
    path('start_rosbag_recording/', views.start_rosbag_recording, name='start_rosbag_recording'),
    path('stop_rosbag_recording/', views.stop_rosbag_recording, name='stop_rosbag_recording'),
]
