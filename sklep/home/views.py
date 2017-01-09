from django.shortcuts import render
from django.http import HttpResponse
# Create your views here.
from django.shortcuts import render
from django.http import HttpResponseRedirect,HttpRequest
from django.contrib.auth import logout
from account.views import user_login,register

def index(request):
    if request.user.is_authenticated:
        logUserOut(request)
    else:
        user_login(request)

    if request.user.is_authenticated:
         return render(request, 'index.html')
    else: return HttpResponseRedirect('/register/')

def logUserOut(request):
    if request.method == 'GET':
        log_out = request.GET.getlist('logout')
        if len(log_out)> 0 and log_out[0] == '1':
            logout(request)

