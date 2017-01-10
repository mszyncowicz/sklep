from django.shortcuts import render
from .models import Produkt,Producent,Galeria
from django.http import HttpResponse
# Create your views here.

def product(request, product_id):
    try:
       product_object = Produkt.objects.get(pk = product_id)
       producent_object = Producent.objects.get(pk= product_object.producent.pk)
       galeria_objects = Galeria.objects.filter(produkt = product_id)
    except (Produkt.DoesNotExist, Producent.DoesNotExist, Galeria.DoesNotExist):
        return render(request, 'index.html')
    return render(request, 'product.html',{'product': product_object, 'producent': producent_object,'galeria': galeria_objects})


def pro(request,product_id):
    print 'bla'
    return HttpResponse( product_id)