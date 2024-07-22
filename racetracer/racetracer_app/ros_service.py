from roslibpy import Ros, Topic
from django.http import JsonResponse
import roslibpy



class RosService:
    
    def __init__(self):
        self.ros = Ros(host='localhost', port=9091)
        self.ros.run()
        

        self.turtle_commander = roslibpy.Topic(self.ros, '/turtle1/cmd_vel', 'geometry_msgs/Twist')



    def get_nodes(self):
        return self.ros.get_nodes()
    

    def get_node_info(self, node_name):
        return self.ros.get_node_details(node_name)
    
    def get_nodes_info(self):
        nodes_info = []
        nodes = self.get_nodes()

        for node_name in nodes:
            node_info = self.get_node_info(node_name)
            nodes_info.append({
                'node_name': node_name,
                'node_info': node_info
            })

        return nodes_info


    def shutdown(self):
        self.client.terminate()
    # def get_ros_nodes(self,request):
    #     try:
    #         nodes = self.ros.get_nodes()
    #         return JsonResponse({'nodes': nodes})
    #     except Exception as e:
    #         return JsonResponse({'error': str(e)})
        

    


          
    # def get_ros_topics(self):
    #     try:
    #         topics = self.ros.get_topics()
    #         return JsonResponse({'topics': topics})
    #     except Exception as e:
    #         return JsonResponse({'error': str(e)})
        
    
        

    def publish_message(self, topic_name, message):
        talker = roslibpy.Topic(self.ros, topic_name, 'std_msgs/String')
        talker.publish(roslibpy.Message({'data': message}))
        talker.unadvertise()

    def subscribe_to_topic(self, topic_name, callback):
        listener = roslibpy.Topic(self.ros, topic_name, 'std_msgs/String')
        listener.subscribe(callback)

        self.turtle_commander = roslibpy.Topic(
            self.client, '/turtle1/cmd_vel', 'geometry_msgs/Twist')

    def move_turtle(self, linear, angular):
        twist = roslibpy.Message({
            'linear': {
                'x': linear,
                'y': 0.0,
                'z': 0.0
            },
            'angular': {
                'x': 0.0,
                'y': 0.0,
                'z': angular
            }
        })
        self.turtle_commander.publish(twist)

    def shutdown(self):
        self.ros.terminate()
        