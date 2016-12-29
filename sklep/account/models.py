# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models
from django.contrib.auth.models import AbstractUser
# Create your models here.

class User(AbstractUser):
    username = models.CharField(max_length=17, unique=True, validators=[AbstractUser.username_validator])
    email = models.EmailField('e-mail',max_length = 255, unique=True)
    first_name = None
    last_name = None
    def __str__(self):
        return self.username;

class Address (models.Model):
    city = models.CharField('miasto', max_length = 50)
    address = models.CharField('adres', max_length = 255)
    zipcode = models.CharField('kod pocztowy', max_length = 150)

class UserCd(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True)
    fName = models.CharField(u'Imię',max_length=50)
    lName = models.CharField('nazwisko', max_length=50)
    birthDate = models.DateField('data urodzin')
    phone = models.CharField('nr.telefonu',max_length=12)
    address = models.OneToOneField(Address, on_delete=models.CASCADE)


