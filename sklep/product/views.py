from django.shortcuts import render
from .models import Produkt,Producent,Galeria
from django.http import HttpResponse,HttpResponseRedirect
from django.db import transaction, IntegrityError
from .models import Procesor, PlytaGlowna, KartaGraficzna, ToSell
from account.models import Zamowienie
import datetime
# Create your views here.

def product(request, product_id):
    procesory = Producent.objects.raw(
        'select * from product_producent where id in (select producent_id from product_produkt where id in (select produkt_id from product_procesor)) group by nazwa')  # subquery
    karty = Producent.objects.raw(
        'select * from product_producent where id in (select producent_id from product_produkt where id in (select produkt_id from product_kartagraficzna)) group by nazwa')
    plyty = Producent.objects.raw(
        'select * from product_producent where id in (select producent_id from product_produkt where id in (select produkt_id from product_plytaglowna)) group by nazwa')
    if len(request.GET.getlist('cat'))>0:
        return HttpResponseRedirect('/../..?cat=%s&producent=%s' % (request.GET.getlist('cat')[0], request.GET.getlist('producent')[0]))
    dodaj(request, product_id)
    try:
       product_object = Produkt.objects.get(pk = product_id)
       producent_object = Producent.objects.get(pk= product_object.producent.pk)
       galeria_objects = Galeria.objects.filter(produkt = product_id)
    except (Produkt.DoesNotExist, Producent.DoesNotExist, Galeria.DoesNotExist):
        return HttpResponseRedirect('/../..')
    return render(request, 'product.html',{'product': product_object, 'producent': producent_object,'galeria': galeria_objects,'procesory':procesory,'plyty':plyty,'karty':karty})

def basket(request):
    if len(request.GET.getlist('usun'))>0:
        i = int(request.GET.getlist('usun')[0])
        dic = request.session['koszyk']
        del dic[i]
        request.session['koszyk'] = dic
        request.session['koszyklen'] = len(dic)
    dic = []
    sum = 0
    if request.session['koszyklen']>0:
        i = 0

        for p in request.session['koszyk']:
            product = Produkt.objects.get(pk = p[0])
            d = [[product.id, product.nazwa, product.producent, p[1], product.cena,i]]
            sum += product.cena*int(p[1])
            dic += d
            i += 1
    if request.method == 'POST':
        return HttpResponseRedirect('zamow/')
    return render(request,
                  'basket.html', {'dic': dic, 'sum':sum}
                  )
def zamow(request):
    dic =[]
    error = False
    if request.method == "POST":
        try:
            with transaction.atomic():          #start transaction, rollback jesli IntegrityError
                zamowienie = Zamowienie.objects.create(user = request.user, status = 1, statustime= None)
                for p in request.session['koszyk']:
                    product = Produkt.objects.get(pk=p[0])
                    if int(p[1])>product.iloscSztuk:
                        raise IntegrityError()
                    toSell = ToSell.objects.create(iloscSztuk = p[1], produkt = product.id, zamowienie = zamowienie.id)
                    product.update(iloscSztuk = product.iloscSztuk - int(p[1]))
                zamowienie.update(statustime = datetime.datetime.now())
                HttpResponse("Udalo sie zlozyc zamowienie <a href='/zamowienia/'>Zaobacz</a>")
        except IntegrityError:
            error = True
    if error:
        HttpResponse("KRYTYCZNY BLAD, NIEKTORYCH PRODUKTOW NIE MA JUZ W MAGAZYNIE")
    if request.session['koszyklen'] >0:
        i = 0
        sum =0
        for p in request.session['koszyk']:
            product = Produkt.objects.get(pk = p[0])
            d = [[product.id, product.nazwa, product.producent, p[1], product.cena,i]]
            sum += product.cena * int(p[1])
            dic += d
            i += 1
    return render(request,
                  'zamow.html', {'dic': dic, 'sum':sum})

def dodaj(request,product_id):
    if 'koszyk' not in request.session:
        request.session['koszyk'] = []
    koszyk = request.session['koszyk']
    if request.method == 'POST':
        flaga = False
        iloscSztuk = request.POST['ilosc']
        for p in koszyk:
            i = int(p[0])
            produkt = Produkt.objects.get(pk=product_id)
            if i == int(product_id) and int(p[1])+int(iloscSztuk)<=produkt.iloscSztuk:
                p[1] = unicode(int(p[1])+int(iloscSztuk))
                flaga = True
        if not flaga:
           koszyk += [[product_id,iloscSztuk]]
    request.session['koszyklen'] = len(koszyk)
def category (request, product_id, cat_id):
    cat_object = None
    cat_id = int(cat_id)

    procesory = Producent.objects.raw(
        'select * from product_producent where id in (select producent_id from product_produkt where id in (select produkt_id from product_procesor)) group by nazwa')  # subquery
    karty = Producent.objects.raw(
        'select * from product_producent where id in (select producent_id from product_produkt where id in (select produkt_id from product_kartagraficzna)) group by nazwa')
    plyty = Producent.objects.raw(
        'select * from product_producent where id in (select producent_id from product_produkt where id in (select produkt_id from product_plytaglowna)) group by nazwa')
    if len(request.GET.getlist('cat'))>0:
        return HttpResponseRedirect('/../..?cat=%s&producent=%s' % (request.GET.getlist('cat')[0], request.GET.getlist('producent')[0]))
    dodaj(request, product_id)
    if cat_id>3 or cat_id == None:
        return product(request,product_id)
    elif cat_id == 1:
        try:

           cat_object = Procesor.objects.get(produkt=product_id)
        except (Procesor.DoesNotExist):
            return product(request, product_id)
    elif cat_id == 2:
        try:
           cat_object = KartaGraficzna.objects.get(produkt=product_id)
        except (KartaGraficzna.DoesNotExist):
            return product(request, product_id)
    elif cat_id == 3:
        try:
           cat_object = PlytaGlowna.objects.get(produkt=product_id)
        except (PlytaGlowna.DoesNotExist):
           return product(request, product_id)
    try:

        galeria_objects = Galeria.objects.filter(produkt=product_id)
        product_object = Produkt.objects.get(pk=product_id)
        producent_object = Producent.objects.get(pk=product_object.producent.pk)
    except(Produkt.DoesNotExist, Galeria.DoesNotExist,Producent.DoesNotExist):
        return HttpResponseRedirect('/../..')
    return render(request, 'category.html',
                  {'cat': cat_object, 'product': product_object, 'producent': producent_object, 'galeria': galeria_objects, 'category':cat_id,
                   'procesory': procesory, 'plyty': plyty, 'karty': karty})

def zamowienia(request):
    try:
        zam = Zamowienie.objects.filter(user=request.user).latest()
    except Zamowienie.DoesNotExist:
        zam = None
    return render(request,'zamowienia.html',{'zam':zam})


'''
delimiter //
CREATE PROCEDURE dodaj(IN docelowe_id BIGINT UNSIGNED)
BEGIN
    Declare a INT;
    DECLARE b INT;
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT produkt_id, iloscSztuk FROM product_tosell WHERE zamowienie_id = docelowe_id;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
         ROLLBACK;
    END;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done := TRUE;



    START TRANSACTION;
        OPEN cur;
        testloop: LOOP
            FETCH cur INTO a,b;
            IF done THEN
              LEAVE testloop;
            END IF;
            CALL product_UPDATE(a,b);
        END LOOP testloop;
        CLOSE cur;
    COMMIT;
END//
CREATE PROCEDURE product_UPDATE
     (
        IN  p_id                   INT(11)       ,
        IN  p_ilosc                TINYINT(6)
     )
BEGIN

    UPDATE product_produkt
    SET
           ilosc_sztuk  = ilosc_sztuk + p_losc
    WHERE  id = p_id ;

END


CREATE TRIGGER zamowienie_onDelete
BEFORE DELETE
   ON account_zamowienie FOR EACH ROW
BEGIN
    CALL dodaj(OLD.id);
END//

'''