"""
ASGI config for racetracer project.

It exposes the ASGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/5.0/howto/deployment/asgi/
"""

import os
import django
from channels.auth import AuthMiddlewareStack
from channels.routing import ProtocolTypeRouter, URLRouter
from django.core.asgi import get_asgi_application
from messenger_app.routing import websocket_urlpatterns
from channels.routing import get_default_application
from messenger_app import routing

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'racetracer.settings')

django.setup()
application = get_default_application()

application = ProtocolTypeRouter({
    "http": get_asgi_application(),
    "websocket": AuthMiddlewareStack(
        URLRouter(
            routing.websocket_urlpatterns
        )
    ),
})
