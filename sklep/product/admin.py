from django.contrib import admin

# Register your models here.
from .models import Producent,Produkt,Galeria

admin.site.register(Producent)
admin.site.register(Produkt)
admin.site.register(Galeria)