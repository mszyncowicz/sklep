# -*- coding: utf-8 -*-
from django.shortcuts import render
from django.http import HttpResponse
# Create your views here.
from django.db import connection, transaction
from django.shortcuts import render
from django.http import HttpResponseRedirect,HttpRequest
from django.contrib.auth import logout
from account.views import user_login,register
from product.models import Produkt,Producent,Procesor,PlytaGlowna,KartaGraficzna,Kategoria
def index(request):
    if request.user.is_authenticated:
        logUserOut(request)

    else:
        user_login(request)

    if request.user.is_authenticated:
        procesory = Producent.objects.raw('select * from product_producent where id in (select producent_id from product_produkt where id in (select produkt_id from product_procesor)) group by nazwa') #subquery menu
        karty = Producent.objects.raw('select * from product_producent where id in (select producent_id from product_produkt where id in (select produkt_id from product_kartagraficzna)) group by nazwa')
        plyty = Producent.objects.raw('select * from product_producent where id in (select producent_id from product_produkt where id in (select produkt_id from product_plytaglowna)) group by nazwa')
        p = sqlQuery()
        if len(request.GET.getlist('producent'))>0:
            ## używam view:
            i = sqlSearch(request.GET.getlist('cat')[0])
            if i == 1:
                cursor = connection.cursor()
                cursor.execute('select * from procesory where producent = "%s" ' % request.GET.getlist('producent')[0])
                p = cursor.fetchall()
            elif i == 2:
                cursor = connection.cursor()
                cursor.execute('select * from karty where producent = "%s" ' % request.GET.getlist('producent')[0])
                p = cursor.fetchall()
            elif i== 3:
                cursor = connection.cursor()
                cursor.execute('select * from plyty where producent = "%s" ' % request.GET.getlist('producent')[0])
                p = cursor.fetchall()
            else:
                cursor = connection.cursor()
                cursor.execute('select * from procesory where producent = "%s" ' % request.GET.getlist('producent')[0])
                p = cursor.fetchall()
        # zrobic view inner joiny
        return render(request, 'index.html', {'lista':p,'procesory':procesory,'plyty':plyty,'karty':karty})
    else: return HttpResponseRedirect('/register/')

def logUserOut(request):
    if request.method == 'GET':
        log_out = request.GET.getlist('logout')
        if len(log_out)> 0 and log_out[0] == '1':
            logout(request)


def sqlSearch(x):

    return {
        'procesory' : 1,
        'karty' : 2,
        'plyty' : 3,
        'inne' : 4
    }[x]
def sqlQuery():
    p = Produkt.objects.raw('SELECT * FROM product_produkt where iloscsztuk > 0')
    return p

'''
def my_custom_sql():
    from django.db import connection, transaction
    cursor = connection.cursor()

    # Data modifying operation - commit required
    cursor.execute("UPDATE bar SET foo = 1 WHERE baz = %s", [self.baz])
    transaction.commit_unless_managed()

    # Data retrieval operation - no commit required
    cursor.execute("SELECT foo FROM bar WHERE baz = %s", [self.baz])
    row = cursor.fetchone()

    return row

    // mozna uzyc tego do systemu transakcji i ewidencji w czasie zatwierdzania zamowienia

    wincyj - https://docs.djangoproject.com/en/dev/topics/db/sql/

    mysql> select * from product_producent where id in (select product_producent.id
    -> FROM product_procesor
    -> INNER JOIN product_produkt
    -> ON product_procesor.produkt_id = product_produkt.id
    -> INNER JOIN product_producent
    -> on product_producent.id = product_produkt.producent_id);


'''

'''
      mysql> create or replace view procesory AS
    -> select product_produkt.nazwa, product_producent.nazwa as producent, product_produkt.cena, product_produkt.id
    -> from product_produkt
    -> INNER JOIN product_procesor
    -> on product_procesor.produkt_id=product_produkt.id
    -> JOIN product_producent
    -> on product_produkt.producent_id = product_producent.id;

mysql> create or replace view karty AS
    -> select product_produkt.nazwa, product_producent.nazwa as producent, product_produkt.cena, product_produkt.id
    -> from product_produkt
    -> INNER JOIN product_kartagraficzna
    -> on product_kartagraficzna.produkt_id=product_produkt.id
    -> JOIN product_producent
    -> on product_produkt.producent_id = product_producent.id;

mysql> create or replace view plyty AS
    -> select product_produkt.nazwa, product_producent.nazwa as producent, product_produkt.cena, product_produkt.id
    -> from product_produkt
    -> INNER JOIN product_plytaglowna
    -> on product_plytaglowna.produkt_id=product_produkt.id
    -> JOIN product_producent
    -> on product_produkt.producent_id = product_producent.id;

          '''