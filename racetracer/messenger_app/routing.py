from django.urls import re_path
from .consumers import ChatConsumer
from django.urls import path
from channels.routing import ProtocolTypeRouter, URLRouter
from channels.auth import AuthMiddlewareStack
from messenger_app import consumers
from channels.security.websocket import AllowedHostsOriginValidator
from django.core.asgi import get_asgi_application


websocket_urlpatterns = [
    re_path(r'ws/chat/(?P<room_name>\w+)/$', ChatConsumer.as_asgi()),
]
