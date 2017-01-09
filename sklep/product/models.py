# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models

# Create your models here.

class Producent (models.Model):
    nazwa = models.CharField(max_length=255, unique=True)

    def __unicode__(self):
        return self.nazwa
class Produkt (models.Model):
    nazwa = models.CharField(max_length=255, unique = True)
    opis = models.CharField(max_length=600)
    producent = models.ForeignKey(Producent)
    iloscSztuk = models.IntegerField(default = 0, max_length=2000)

    def __unicode__(self):
        return self.nazwa
class Galeria (models.Model):
    obraz = models.ImageField(max_length=4096)
    produkt = models.ForeignKey(Produkt)
    def __unicode__(self):
        return 'obraz ' + self.produkt.nazwa

# zamowienie nie może wykorzystywać on Delete, ponieważ usunie to pewna ilosc sztuk towaru bezpowrotnie
class ToSell (models.Model):
    produkt = models.ForeignKey(Produkt)
    iloscSztuk = models.IntegerField()
    zamowienie = models.OneToOneField('account.Zamowienie', default=None)