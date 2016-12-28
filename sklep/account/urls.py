from django.conf.urls import url
from . import views

urlpatterns = [
    #127.0.0.1:8000
    url(r'^$', views.register, name='index'),
]