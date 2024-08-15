#!/usr/bin/env python
import rospy
from std_msgs.msg import String
from ros_app.models import ROSMessage

def callback(data):
    rospy.loginfo("I heard %s", data.data)
    # Save the message to the database
    ROSMessage.objects.update_or_create(id=1, defaults={'message': data.data})

def listener():
    rospy.init_node('listener', anonymous=True)
    rospy.Subscriber('chatter', String, callback)
    rospy.spin()

if __name__ == '__main__':
    import django
    import os
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "myproject.settings")
    django.setup()
    listener()
