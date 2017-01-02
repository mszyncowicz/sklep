from django.shortcuts import render,render_to_response

from django.http import HttpResponse
from .models import User
from django.contrib.auth import authenticate, login
from .forms import UserCdForm,UserForm,AddressForm
# Create your views here.

def register(request):
    if request.method == 'POST':
        uf = UserForm(request.POST, prefix='user')
        ucf = UserCdForm(request.POST, prefix='usercd')
        af = AddressForm(request.POST, prefix='address')
        if uf.is_valid() * ucf.is_valid() * af.is_valid():
            user = uf.save()
            address = af.save()
            usercd = ucf.save(commit=False)
            usercd.user = user
            usercd.address = address
            usercd.save()
            return HttpResponse('Acount created, <a href="index.html">go back</a>')
    else:
        uf = UserForm(prefix='user')
        ucf = UserCdForm(prefix='usercd')
        af = AddressForm(prefix='adresss')
    return render(request,
                  'account/register.html',
                  dict(userform=uf,
                       usercdform=ucf,
                       address = af),
                  )
def user_login(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(username=username, password=password)
        if user is not None:
            login(request, user)
            return HttpResponse("Logged in")
        else:
            return HttpResponse("Wrong login or passowrd.")
    else:
        return render(request, 'base.html',{})


