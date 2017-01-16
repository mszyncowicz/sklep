from django.contrib import admin

# Register your models here.
from .models import Producent,Produkt,Galeria, Procesor, PlytaGlowna, KartaGraficzna

admin.site.register(Producent)
admin.site.register(Produkt)
admin.site.register(Galeria)
admin.site.register(Procesor)
admin.site.register(KartaGraficzna)
admin.site.register(PlytaGlowna)