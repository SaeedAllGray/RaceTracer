
<img src="https://github.com/user-attachments/assets/d0fdfb1b-e8fb-4510-addf-71c980846909" alt="Screenshot 2025-01-04 at 13 13 59" width="10000"/>




# RaceTracer

An open‐source full‐stack software powered by Python(Django), Flutter(Dart) and ROS (C/C++). RaceTracer automates the testing and documentation of our autonomous racing car on the track. By connecting directly to the car, it provides a platform for all team members to record detailed observations, making the test procedures more coordinated and the analysis more meaningful.

The backends runs directly on the car to maintain a direct connection with the driverless software, git and ROS.

## [RaceTracer introduction on GET racing developers' confrence](https://www.youtube.com/watch?v=0kCfCOqn7T0)

# GET racing Dortmund e.V
In 2024, GET Racing Dortmund soared to victory as the champion of France, celebrating the most successful year in its 20-year history. This remarkable achievement highlights two decades of dedication, innovation, and excellence in racing.

We are thrilled to share our achievements with the community! By standardizing and enhancing our software tools, teams can minimize the time spent troubleshooting basic functionalities, allowing them to dedicate more energy to advancing their driverless vehicle solutions. This shift not only elevates the quality of competition in tournaments but also empowers teams to concentrate on groundbreaking innovations in driverless technology. Together, we are paving the way for a new era of automotive excellence!



## Getting Started
RaceTracer is developed for formula student teams. To use it, some configurations should be done. The backend should run on the car to be in direct connection with the project repository, git and ROS. Therefore the Git changes automaticaly.

### Git 
In the app, basic Git commands like `add`, `commit`, and `push` are handled automatically with a single click. You simply need to enter your commit message, and the app takes care of the rest. To make it happens you need to import the project in the `Race-tracer/racetracer/config.yaml`: 

```yaml
git:
  project_directory: /path/to/your/project/
  track_files:
   - path/to/example/configuration/file.yaml
   - path/to/another/example/configuration/file.yaml

```
When it's all set and done, RaceTracer makes a branch called `racetracer`.

From the app, you can specify which files you wish to track for changes, allowing you to review and manage file updates selectively.
To do so, import the file relative path under `track_files`.

When it's all set and done, RaceTracer makes a branch called racetracer.

### GitLab OAuth

To enable other team members to use the app, you need to set up GitLab OAuth for seamless authentication and secure access.

-  Create a user-owned application [Read More](https://docs.gitlab.com/ee/integration/oauth_provider.html#create-a-user-owned-application)
- Navigate to `Race-tracer/racetracer/config.yaml` and change the following attributes based on the Gitlab: 

```yaml
oauth:
  client_id: xxxxxxxxxxxxxxx
  client_secret: xxxxxxxxxxxxxxx
  issuer: xxxxxxxxxxxxxxx
  discovery_url: xxxxxxxxxxxxxxx

```

## GitLab API
Find your driverless software project id on gitlab:
```yaml
gitlab:
  project_id: "1234"
  ```

### Scripts
Using custom scripts, you can perform additional calculations on your ROS messages and monitor their values in real time under the "Watch List" tab right on your smartphone. For each script, the ros topic and label should be specfied: 

```yaml
scripts:
- label: blue_cones
  topic: /jarvic/estimation/map
  code: |
    value = sum([(1 if max(range(len(c)), key=lambda i: c[i]) == 1 else 0) for c in x['cones']])
- label: clock
  topic: /clock
  code: |
    value = x['clock']['secs']
```

### Mobile App


- The latest version of RaceTracer App for iOS and Android can be found [Coming soon](https://apple.de).

- The mobile app is developed with Flutter and Dart. In case you wish to customize the app: [Read More](https://docs.flutter.dev/get-started/install) 

## How to make the backend running
This process is highly dependent on the specific driverless software you are using. Here’s the approach followed by GET Racing:

1. Initiate the ROS: 
```bash
roscore
```

2. Run the ROS bridge using the port 9091:
```bash
roslaunch rosbridge_server rosbridge_websocket.launch port:=9091
```
If you need to use a different port, you can modify it in the following directory: `/race-tracer/racetracer/ros_app/ros_service.py`:
```bash
self.ros = roslibpy.Ros(host='localhost', port=9090)
```

3. Run your driverless software.
4. Run the backend on your preferred port. However, please ensure that you do not use the same port for both the rosbridge and the backend to avoid any conflicts:

```bash
python manage.py runserver 0.0.0.0:8000
```

 
## How to use the App [Coming soon]

### Configuration 
Enter the backend IP to let app obtain the configurations.

<img src="https://github.com/user-attachments/assets/c82ae3bb-3187-4905-abfd-b3403e0bbf67" alt="29" width="200"/>
<img src="https://github.com/user-attachments/assets/cf946706-bda1-4c41-8d62-b3ecf12ae317" alt="28" width="200"/>


### Authentication
After configuration obtained successfully, sign in with gitlab credentials. 

<img src="https://github.com/user-attachments/assets/e0e2c4d3-b0bb-4d13-9cd7-1545a6cb9e3f" alt="36" width="200"/>
<img src="https://github.com/user-attachments/assets/d9d709f1-4067-4711-b4f7-e01bf611bbf6" alt="37" width="200"/>
<img src="https://github.com/user-attachments/assets/275f0c4c-c96d-44fe-832d-f20839b2117b" alt="34" width="200"/>

### Dashboard
RaceTracer provides and overview of the nodes and topics. You can search through the topics and see the nodes' publishers and subscribers.

<img src="https://github.com/user-attachments/assets/446fd32c-fd94-4e47-8ea3-2771853ccf01" alt="32" width="200"/>
<img src="https://github.com/user-attachments/assets/f78906be-82b2-4b89-88a9-90dc6036931f" alt="31" width="200"/>
<img src="https://github.com/user-attachments/assets/8323c013-59ab-4e1f-b328-c3a0c044ab46" alt="27" width="200"/>
<img src="https://github.com/user-attachments/assets/0ca55956-1998-43a7-ac04-0286f6730257" alt="24" width="200"/>

### one commit == one test session
RaceTracer commit the changes of your code automatically on the racetrack. We know this process was pain in the neck and we are always lazy to do it because we are under pressure and stress during the tornoment. As soon as the commit is generated, you can record the incidents in the discussion section integrated to racetracer. RaceTracer can generate a document using all the data you submited in the chat.

<img src="https://github.com/user-attachments/assets/fbeaa9a1-4ebc-44fe-90a8-f931a7f1b1b4" alt="9" width="200"/>
<img src="https://github.com/user-attachments/assets/4d9eaee1-528c-4208-b858-e66e6b589fac" alt="10" width="200"/>
<img src="https://github.com/user-attachments/assets/82de2531-e6ce-433b-95c0-02016c9421c9" alt="8" width="200"/>
<img src="https://github.com/user-attachments/assets/af8880d6-184b-4b08-8b11-236b127691a3" alt="7" width="200"/>
<img src="https://github.com/user-attachments/assets/ccd27852-9e9b-4b72-bb81-87cd25ab7c3b" alt="4" width="200"/>
<img src="https://github.com/user-attachments/assets/414b090d-8bba-48e5-91e9-d79a8d622440" alt="5" width="200"/>
<img src="https://github.com/user-attachments/assets/3e414cb5-4cd1-4a4f-95a6-d9f69d91a9b2" alt="3" width="200"/>

### Watch List
RaceTracer offers an overview of the data recieved from ROS nodes and topics. You can filter and specify the exact data you wish to have a glance in watchlist page.
You can even write scripts on backend config file and see them on the mobile app.

<img src="https://github.com/user-attachments/assets/14fffddd-a0cc-4408-9364-c020da52020f" alt="25" width="200"/>
<img src="https://github.com/user-attachments/assets/7f7b5da5-f68c-4f5f-9827-a2a435469c02" alt="23" width="200"/>
<img src="https://github.com/user-attachments/assets/b912fbaf-1232-4596-9e74-f5ee7545afa7" alt="18" width="200"/>
<img src="https://github.com/user-attachments/assets/83c5ea60-6756-4e50-80db-dd29aec4411e" alt="16" width="200"/>

### Share the watch list with your teammates
<img src="https://github.com/user-attachments/assets/393d2583-9682-42ab-a039-6c7e1a9ca3b5" alt="15" width="200"/>












Made with ♥️ in Dortmund, Germany 🇩🇪. 
