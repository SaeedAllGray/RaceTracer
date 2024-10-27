# RaceTracer

An open‐source full‐stack software powered by Python(Django) and ROS (C/C++). RaceTracer automates the testing and documentation of our autonomous racing car on the track. By connecting directly to the car, it provides a platform for all team members to record detailed observations, making the test procedures more coordinated and the analysis more meaningful.

The backends runs directly on the car to maintain a direct connection with the driverless software, git and ROS.


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


- The latest version of RaceTracer App for iOS and Android can be found [here](https://apple.de).

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

### Authentication
After configuration obtained successfully, sign in with gitlab credentials. 














Made with ♥️ in Dortmund, Germany 🇩🇪. 
