# -*- coding: utf-8 -*-
# Generated by Django 1.10.4 on 2017-01-14 00:53
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('product', '0006_auto_20170114_0150'),
    ]

    operations = [
        migrations.AlterField(
            model_name='produkt',
            name='cena',
            field=models.DecimalField(decimal_places=2, default=100000000, max_digits=6),
        ),
    ]