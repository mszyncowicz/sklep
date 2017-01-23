# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models

# Create your models here.

class Producent (models.Model):
    nazwa = models.CharField(max_length=255, unique=True)

    def __unicode__(self):
        return self.nazwa
class Kategoria(models.Model):
    liczba = models.IntegerField()
    def __unicode__(self):
        if self.liczba == 1:
            return 'Procesor'
        elif self.liczba == 2:
            return 'Karta graficzna'
        elif self.liczba == 3:
            return 'Plyta glowna'
        else:
            return 'Inne'

class Produkt (models.Model):
    nazwa = models.CharField(max_length=255, unique = True)
    opis = models.CharField(max_length=600)
    producent = models.ForeignKey(Producent)
    iloscSztuk = models.IntegerField(default = 0)
    cena = models.FloatField(default = 99999)
    category = models.ForeignKey(Kategoria, default=None)
    def __unicode__(self):
        return self.nazwa
class Galeria (models.Model):
    obraz = models.ImageField(max_length=4096)
    produkt = models.ForeignKey(Produkt)
    def __unicode__(self):
        return 'obraz ' + self.produkt.nazwa


class KartaGraficzna(models.Model):
    produkt = models.OneToOneField(Produkt, primary_key=True)
    wyjscia = models.CharField(max_length=255)
    zlacze = models.CharField(max_length=255)
    TDP = models.CharField(max_length=255)

class Procesor(models.Model):
    produkt = models.OneToOneField(Produkt, primary_key=True)
    socket = models.CharField(max_length=255)
    TDP = models.CharField(max_length=255)

class PlytaGlowna(models.Model):
    produkt = models.OneToOneField(Produkt, primary_key=True)
    sockety = models.CharField(max_length=255)
    wyjscia = models.CharField(max_length=255)

# zamowienie nie może wykorzystywać on Delete cascade, ponieważ usunie to pewna ilosc sztuk towaru bezpowrotnie
#trzeba uzyc funkcji!!!!!!
class ToSell (models.Model):
    produkt = models.ForeignKey(Produkt)
    iloscSztuk = models.IntegerField()
    zamowienie = models.ForeignKey('account.Zamowienie', default= None, on_delete=models.CASCADE)