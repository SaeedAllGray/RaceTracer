from django.db import models

class ROSMessage(models.Model):
    message = models.CharField(max_length=255)
