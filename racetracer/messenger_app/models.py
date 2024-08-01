from django.db import models
from django.contrib.auth.models import User

class Tag(models.Model):
    title = models.CharField(max_length=100)


class Message(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    text = models.TextField(null=True, blank=True)
    photo = models.ImageField(upload_to='photos/', null=True, blank=True)
    tag = models.ForeignKey(Tag, on_delete=models.SET_NULL, null=True, blank=True)
    timestamp = models.DateTimeField(auto_now_add=True)
    test_session = models.ForeignKey('TestSession', related_name='messages', on_delete=models.CASCADE)


class TestSession(models.Model):
    timestamp = models.DateTimeField(auto_now_add=True)
