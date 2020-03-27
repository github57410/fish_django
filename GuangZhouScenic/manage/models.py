from datetime import datetime

from django.db import models



class Admin(models.Model):
    id = models.IntegerField(primary_key=True, auto_created=True)
    name = models.CharField(max_length=32)
    number = models.CharField(max_length=16, unique=True)
    password = models.CharField(max_length=64)
    create_time = models.DateTimeField(default=datetime.now)

    class Meta:
        db_table = 'admin'


class User(models.Model):
    id = models.IntegerField(primary_key=True, auto_created=True)
    name = models.CharField(max_length=32)
    number = models.CharField(max_length=16, unique=True)
    password = models.CharField(max_length=64)
    create_time = models.DateTimeField(default=datetime.now)

    class Meta:
        db_table = "user"


class Scenic(models.Model):
    id = models.AutoField(primary_key=True, auto_created=True)
    name = models.CharField(max_length=255)
    img = models.CharField(max_length=255)
    intro = models.CharField(max_length=255)
    content = models.CharField(max_length=2000)
    address = models.CharField(max_length=255)
    ticket_price = models.CharField(max_length=100)
    open_time = models.CharField(max_length=100)
    is_hot = models.CharField(max_length=1)
    create_time = models.DateTimeField(default=datetime.now)

    class Meta:
        db_table = "scenic"


class Article(models.Model):
    id = models.AutoField(primary_key=True, auto_created=True)
    title = models.CharField(max_length=255)
    user_id = models.CharField(max_length=10)
    scenic_id = models.CharField(max_length=10)
    text = models.CharField(max_length=255)
    content = models.CharField(max_length=2000)
    create_time = models.DateTimeField(default=datetime.now)

    class Meta:
        db_table = "article"
