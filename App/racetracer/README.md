
# RaceTracer

A brief description of what this project does and who it's for



## Getting Started

RaceTracer is developed for formula student teams. To use it, some configurations should be done. 

- Develop and deploy with Flutter [Read More](https://docs.flutter.dev/get-started/install)


## GitLab OAuth
It's assumed that you are using gitlab for development. In this case the following steps should be taken:

-  Create a user-owned application [Read More](https://docs.gitlab.com/ee/integration/oauth_provider.html#create-a-user-owned-application)
- Navigate to `lib/src/presentation/constants/api_constant.dart` and change the following attributes based on the Gitlab: 

```python
static const String CLIENT_ID = 'TO BE CHANGED';
static const String CLIENT_SECTRET = 'TO BE CHANGED';
static const String REDIRECT_URL = 'TO BE CHANGED';
static const String ISSUER = 'TO BE CHANGED';
static const String DISCOVERY_URL = 'TO BE CHANGED';
```

## GitLab API
