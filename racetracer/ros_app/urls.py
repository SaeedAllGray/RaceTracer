from django.urls import path
from . import views

urlpatterns = [
    path('start_ros_node/', views.start_ros_node, name='start_ros_node'),
    path('nodes/', views.get_ros_nodes, name='get_nodes'),
    # path('nodes/', views.get_active_nodes, name='get_nodes'),
    path('topics/', views.get_ros_topics, name='get_topics'),
    path('topics/info/', views.get_ros_topics_info, name='get_topics_info'),
    path('nodes/info/', views.get_ros_nodes_info, name='get_nodes_info'),
    path('topic/<path:topic_name>/info/', views.get_topic_info, name='get_topic_info'),
    path('node/<path:node_name>/info/', views.get_ros_node_info, name='get_node_info'),
    path('stop_ros_node/', views.stop_ros_node, name='stop_ros_node'),
    # path('start/', views.start_services, name='roscore'),
    path('bag/record/', views.start_rosbag_recording, name='start_rosbag_recording'),
    path('bag/stop/', views.stop_rosbag_recording, name='stop_rosbag_recording'),
    path('topic/message/', views.get_message, name='show_message'),
    path('topic/message/evaluate/', views.evaluate, name='evaluate message'),
    path('code/titles/', views.get_code_titles, name='get code titles'),
    path('topic/values/', views.executeTopicMessages, name='get the values'),


]