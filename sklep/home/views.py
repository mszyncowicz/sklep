from django.shortcuts import render
from django.http import HttpResponse
# Create your views here.
from django.shortcuts import render
from django.http import HttpResponseRedirect,HttpRequest
from django.contrib.auth import logout
from account.views import user_login,register
from product.models import Produkt

def index(request):
    if request.user.is_authenticated:
        logUserOut(request)

    else:
        user_login(request)

    if request.user.is_authenticated:
        p = sqlQuery(request)
        return render(request, 'index.html', {'lista':p})
    else: return HttpResponseRedirect('/register/')

def logUserOut(request):
    if request.method == 'GET':
        log_out = request.GET.getlist('logout')
        if len(log_out)> 0 and log_out[0] == '1':
            logout(request)


def sqlQuery(request):
    p = Produkt.objects.raw('SELECT * FROM product_produkt')
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

'''