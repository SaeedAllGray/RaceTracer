import roslibpy
import time

class ROSClient:
    _instance = None

    def __new__(cls, *args, **kwargs):
        if not cls._instance:
            cls._instance = super(ROSClient, cls).__new__(cls, *args, **kwargs)
            cls._instance.client = roslibpy.Ros(host='localhost', port=9090)
            cls._instance.connect()
        return cls._instance

    def connect(self):
        while not self._instance.client.is_connected:
            try:
                self._instance.client.run()
                print("Connected to ROS.")
            except roslibpy.RosTimeoutError as e:
                print(f"Failed to connect to ROS: {e}. Retrying in 5 seconds...")
                time.sleep(5)

    def get_client(self):
        if not self._instance.client.is_connected:
            self._instance.connect()
        return self._instance.client

ros_client = ROSClient().get_client()
