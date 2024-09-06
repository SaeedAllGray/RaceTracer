import roslibpy
# import rospy
import time

class RosService:
    def __init__(self):

        self.ros = roslibpy.Ros(host='localhost', port=9091)
        self.ros.on_ready(self.on_ready)
        self.ros.run()
        self.subscriber = {}
        self.message = {}



        if not self.ros.is_connected:
            print("Failed to connect to ROS bridge")
        else:
            print("Successfully connected to ROS bridge")




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

    def get_topics(self):
        return self.ros.get_topics()
    
    def get_topic_info(self, topic) -> str:
        return self.ros.get_topic_type(topic)
    
    def get_topics_info(self):
        topics_info = []
        topics = self.get_topics()
        for topic_name in topics:
            topic_info = self.get_topic_info(topic_name)
            topics_info.append({
                'topic': topic_name,
                'type': topic_info
            })
        return topics_info

    def shutdown(self):
        self.ros.terminate()

    def on_ready(self):
        print("ROS is ready")
        # Initialize other aspects of your ROS setup here

    def subscribe_to_topic(self, topic_name):
        # self.rospy_message(topic_name)
        # self.message[topic_name] = {'message':'No Value Published','ros_error':True}
        self.message[topic_name] = {}
        # if self.subscriber:
        #     self.subscriber.unsubscribe()
        #     print('unsubed.....')


        type = self.ros.get_topic_type(topic_name)

        if not type:
            print(f"Failed to get type for topic {topic_name}")
            return
        
        self.subscriber[topic_name] = roslibpy.Topic(self.ros, topic_name, type)

        self.subscriber[topic_name].subscribe(lambda msg: self.callback(msg, topic_name))
        # time.sleep(2)
        print('Subscription completed')

       

    def callback(self, message, topic_name):
        # print('Received message:', message, 'on topic', topic_name)
        self.message[topic_name] = message
        # self.subscriber.unsubscribe()
        

    def get_message(self, topic):
        if topic in self.message:
            return self.message[topic]
        return {}


    # def rospy_message(self,topic_name):
        # rospy.init_node('my_node')
        # type = self.ros.get_topic_type(topic_name)


        # try:
        #     # Wait for a message on the topic '/chatter'
        #     message = rospy.wait_for_message(topic_name, type, timeout=1)  # Timeout in seconds
        #     print('Received message:', message.data)
            
        # except rospy.ROSException:
        #     print('No message received within the timeout period.')


