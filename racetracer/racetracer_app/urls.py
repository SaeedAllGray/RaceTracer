from django.urls import path
from . import views
from .ros_service import RosService



urlpatterns = [
    path('start_ros_node/', views.start_ros_node, name='start_ros_node'),
    path('nodes/', views.get_ros_nodes, name='get_nodes'),
    # path('nodes/', views.get_active_nodes, name='get_nodes'),
    path('topics/', views.get_ros_topics, name='get_topics'),
    path('nodes/info/', views.get_ros_nodes_info, name='get_nodes_info'),
    path('topic/<path:topic_name>/info/', views.get_topic_info, name='get_topic_info'),
    path('node/<path:node_name>/info/', views.get_ros_node_info, name='get_node_info'),
    path('stop_ros_node/', views.stop_ros_node, name='stop_ros_node'),
    path('core/', views.start_roscore, name='roscore'),
    path('start_rosbag_recording/', views.start_rosbag_recording, name='start_rosbag_recording'),
    path('stop_rosbag_recording/', views.stop_rosbag_recording, name='stop_rosbag_recording'),
]