from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import MessageViewSet, TagViewSet, TestSessionViewSet, RegisterView, ObtainAuthTokenView, SessionMessagesView
from rest_framework.authtoken.views import obtain_auth_token
from rest_framework.routers import DefaultRouter

router = DefaultRouter()
router.register(r'messages', MessageViewSet)
router.register(r'tags', TagViewSet)
router.register(r'testsessions', TestSessionViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('register/', RegisterView.as_view(), name='register'),
    path('token/', ObtainAuthTokenView.as_view(), name='obtain_auth_token'),
    path('testsessions/<int:session_id>/messages/', SessionMessagesView.as_view(), name='session-messages'),

]
