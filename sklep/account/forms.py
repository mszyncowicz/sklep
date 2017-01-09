# -*- coding: utf-8 -*-
from django import forms
from django.contrib.auth.models import UserManager
import datetime

from django.db import models

from .models import User, UserCd, Address

class UserForm (forms.ModelForm):
    error_messages = {
        'password_mismatch': (u"Wpisałeś dwa różne hasła"),
    }
    password1 = forms.CharField(label=(u"Hasło"),widget=forms.PasswordInput())
    password2 = forms.CharField(label=(u"Potewierdź hasło"),widget=forms.PasswordInput(), help_text=(u"Wpisz to samo hasło co powyżej w celu weryfikacji"))
    class Meta:
        model = User
        exclude = ['password','is_staff','is_active','date_joined','is_superuser','groups','user_permissions','last_login']
    def clean_password2(self):
        password1 = self.cleaned_data.get("password1")
        password2 = self.cleaned_data.get("password2")
        if password1 and password2 and password1 != password2:
            raise forms.ValidationError(
                self.error_messages['password_mismatch'],
                code='password_mismatch',
            )
        return password2

    def save(self):
        user = User.objects.create_user(username = self.cleaned_data["username"], email = self.cleaned_data["email"], password = self.cleaned_data["password1"])
        return user

class UserCdForm(forms.ModelForm):
    error_messages = {
        'too_young': (u"Jesteś za młody na zabawę w sklep")
    }
    birth = forms.DateField(label=(u"Data urodzenia"),widget=forms.SelectDateWidget(years = range(1900,2016)))
    class Meta:
        model = UserCd
        exclude = ['user','address','birthDate']

    def clean_birth(self):
        now = datetime.datetime.now()
        birth = self.cleaned_data.get('birth')

        if now and birth and now.year - birth.year < 18 or now.year - birth.year <= 18 and now.month - birth.month < 0:
            raise forms.ValidationError(
                self.error_messages['too_young'],
                code='too_young',
            )
        return birth

    def save(self, commit=True):
        usercd = super(UserCdForm, self).save(commit=False)
        usercd.birthDate = self.cleaned_data['birth']
        if commit:
            usercd.save()
        return usercd

class AddressForm(forms.ModelForm):
    class Meta:
        model = Address
        exclude = []

