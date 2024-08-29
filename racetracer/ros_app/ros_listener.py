#!/usr/bin/env python
import rospy
from std_msgs.msg import String
from ros_app.models import ROSMessage


class RosNode:
    def __init__(self):
        rospy.init_node('django_ros_node', anonymous=True)
        self.data = None
        rospy.Subscriber('chatter', String, self.callback)

    def callback(self, data):
        rospy.loginfo(rospy.get_caller_id() + " I heard %s", data.data)
        self.data = data.data

    def get_data(self):
        return self.data