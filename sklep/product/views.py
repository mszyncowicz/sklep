from django.shortcuts import render
from .models import Produkt,Producent,Galeria
from django.http import HttpResponse,HttpResponseRedirect
from django.db import transaction, IntegrityError, connection
from .models import Procesor, PlytaGlowna, KartaGraficzna, ToSell, Kategoria
from account.models import Zamowienie,User
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
    return render(request, 'product.html',{'product': product_object, 'producent': producent_object,'galeria': galeria_objects,'procesory':procesory,'plyty':plyty,'karty':karty })

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
    print 'bla1'
    if request.method == "POST":
        try:

            with transaction.atomic():          #start transaction, rollback jesli IntegrityError

                zamowienie = Zamowienie(user = request.user, status = 1)
                zamowienie.statustime = datetime.datetime.now()
                zamowienie.save()
                for p in request.session['koszyk']:
                    product = Produkt.objects.get(pk=p[0])
                    print int(p[1])
                    if int(p[1])>product.iloscSztuk:
                        raise IntegrityError()
                    toSell = ToSell.objects.create(iloscSztuk = p[1], produkt = Produkt.objects.get(pk=product.id), zamowienie = zamowienie)
                request.session['koszyk'] = []
                request.session['koszyklen'] = 0
                cursor = connection.cursor()
                cursor.execute('CALL odejmij(%s)' % zamowienie.id)
                return HttpResponse("Udalo sie zlozyc zamowienie <a href='/zamowienia/'>Zobacz</a>")
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
                   'procesory': procesory, 'plyty': plyty, 'karty': karty,'random':randomThree()})

def zamowienia(request):
    zam = 1
    if len(request.GET.getlist('zam'))>0:
        zam = int(request.GET.getlist('zam')[0])
    if len(request.GET.getlist('usun'))>0:
        usun = int(request.GET.getlist('usun')[0])
        Zamowienie.objects.get(pk=usun).delete()
    cursor = connection.cursor()
    cursor.execute('select *, suma(id), produkty(id) from account_zamowienie where user_id = "%s" and status = "%s" order by statustime desc' % (request.user.pk,zam))
    zam = cursor.fetchall()
    return render(request,'zamowienia.html',{'zam':zam})
def search(request):
    if request.method == 'POST':
        if request.POST['search']:
            x = request.POST['search']
            cursor = connection.cursor()
            cursor.execute( 'select product_produkt.id, product_produkt.nazwa, product_produkt.iloscSztuk, product_produkt.cena, product_producent.nazwa from product_produkt inner join product_producent on product_produkt.producent_id=product_producent.id where product_produkt.nazwa LIKE "%%%s%%" or product_producent.nazwa LIKE "%%%s%%"' % (x,x))
            wyniki = cursor.fetchall()
            return render(request,'search.html',{'wyniki':wyniki})
        else:
            return HttpResponseRedirect('../');

    else:
        return HttpResponseRedirect('../');
def randomThree():
    cursor = connection.cursor()
    cursor.execute(
        'select product_produkt.id, product_produkt.nazwa, product_kategoria.liczba, product_produkt.cena, product_galeria.obraz from product_produkt inner join product_galeria on product_produkt.id = product_galeria.produkt_id inner join product_kategoria on product_produkt.category_id = product_kategoria.id ORDER BY RAND() LIMIT 3' )
    return cursor.fetchall();


'''
delimiter //
CREATE PROCEDURE odejmij(IN docelowe_id BIGINT UNSIGNED)
BEGIN
    Declare a INT;
    DECLARE b INT;
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT produkt_id, iloscSztuk FROM product_tosell WHERE zamowienie_id = docelowe_id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done := TRUE;

    OPEN cur;
    testloop: LOOP
        FETCH cur INTO a,b;
        IF done THEN
            LEAVE testloop;
        END IF;
        CALL product_UPDATEsub(a,b);
    END LOOP testloop;
    CLOSE cur;
END//
///////////////////////////////////////
CREATE FUNCTION suma(docelowe_id BIGINT UNSIGNED) returns decimal(7,2)
BEGIN
    Declare a INT;
    Declare b INT;
    Declare var DOUBLE;
    Declare sum DECIMAL(7,2) DEFAULT 0;
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT produkt_id, iloscSztuk FROM product_tosell WHERE zamowienie_id = docelowe_id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done := TRUE;
    OPEN cur;
    testloop: LOOP
        FETCH cur INTO a,b;
        IF done THEN
            LEAVE testloop;
        END IF;
        SELECT cena into @var from product_produkt where id = a;
        set @var = @var * b;
        set sum = sum + @var;
    END LOOP testloop;
    CLOSE cur;
    RETURN(sum);
END//
CREATE FUNCTION produkty(docelowe_id BIGINT UNSIGNED) returns VARCHAR(500)
BEGIN
    Declare a INT;
    Declare b INT;
    Declare var VARCHAR(255) DEFAULT "";
    Declare sum VARCHAR(500) DEFAULT "";
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT produkt_id, iloscSztuk FROM product_tosell WHERE zamowienie_id = docelowe_id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done := TRUE;
    OPEN cur;
    testloop: LOOP
        FETCH cur INTO a,b;
        IF done THEN
            LEAVE testloop;
        END IF;
        SELECT nazwa into @var from product_produkt where id = a;

        set sum = CONCAT(sum, CONVERT(b,CHAR(50) CHARACTER set latin1),'x ', @var, '\n');
    END LOOP testloop;
    CLOSE cur;
    RETURN(sum);
END//
   set @var = @var + " x" + b + "\n";
/////////////////////////////
CREATE PROCEDURE product_UPDATE
     (
        IN  p_id                   INT(11)       ,
        IN  p_ilosc                TINYINT(6)
     )
BEGIN

    UPDATE product_produkt
    SET
           iloscSztuk  = iloscSztuk + p_ilosc
    WHERE  id = p_id ;

END
////////////////////
CREATE PROCEDURE product_UPDATEsub
     (
        IN  p_id                   INT(11)       ,
        IN  p_ilosc                TINYINT(6)
     )
BEGIN

    UPDATE product_produkt
    SET
           iloscSztuk  = iloscSztuk - p_ilosc
    WHERE  id = p_id ;

END


CREATE TRIGGER zamowienie_onDelete
BEFORE DELETE
   ON account_zamowienie FOR EACH ROW
BEGIN
    CALL dodaj(OLD.id);
END//

CREATE TRIGGER tosell_onDelete
BEFORE DELETE
   ON product_tosell FOR EACH ROW
BEGIN
   CALL product_UPDATE(OLD.produkt_id,OLD.iloscSztuk);
END//

'''