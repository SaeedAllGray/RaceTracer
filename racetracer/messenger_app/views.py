from django.shortcuts import render

# Create your views here.

from rest_framework import viewsets
from .models import Message, Tag, TestSession
from .serializers import MessageSerializer, TagSerializer, TestSessionSerializer, RegisterSerializer
from rest_framework.response import Response
from rest_framework.authtoken.models import Token
from rest_framework import generics
from django.contrib.auth.models import User


from rest_framework import generics
from rest_framework.permissions import IsAuthenticated,AllowAny

class SessionMessagesView(generics.ListAPIView):
    serializer_class = MessageSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        session_id = self.kwargs['session_id']
        return Message.objects.filter(test_session_id=session_id)


class RegisterView(generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = RegisterSerializer
    permission_classes = [AllowAny]

class ObtainAuthTokenView(generics.GenericAPIView):
    from rest_framework.authtoken.serializers import AuthTokenSerializer
    permission_classes = [AllowAny]
    def post(self, request, *args, **kwargs):
        serializer = self.AuthTokenSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        token, created = Token.objects.get_or_create(user=user)
        return Response({'token': token.key})


class MessageViewSet(viewsets.ModelViewSet):
    queryset = Message.objects.all()
    serializer_class = MessageSerializer

class TagViewSet(viewsets.ModelViewSet):
    queryset = Tag.objects.all()
    serializer_class = TagSerializer

class TestSessionViewSet(viewsets.ModelViewSet):

    queryset = TestSession.objects.all()
    serializer_class = TestSessionSerializer
