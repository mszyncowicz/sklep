from django.shortcuts import render,render_to_response

from django.http import HttpResponse, HttpResponseRedirect
from .models import User
from django.contrib.auth import authenticate, login
from .models import UserCd,Address
from .forms import UserCdForm,UserForm,AddressForm
from django.views.generic.edit import UpdateView, CreateView, FormMixin
from django.db import transaction
# Create your views here.
import datetime

def register(request):
    if request.method == 'POST':
        uf = UserForm(request.POST, prefix='user')
        ucf = UserCdForm(request.POST, prefix='usercd')
        af = AddressForm(request.POST, prefix='address')
        if uf.is_valid() * ucf.is_valid() * af.is_valid():
            with transaction.atomic():
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
        af = AddressForm(prefix='address')
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
            if 'koszyk' not in request.session:
                 request.session['koszyk']=[]
                 request.session['koszyklen'] = len(request.session['koszyk'])
            return HttpResponse("Logged in")
        else:
            return HttpResponse("Wrong login or passowrd.")
    else:
        return render(request, 'index.html',{})

def user_data(request):
    if request.user.is_authenticated:
        usercd = request.user.usercd
        address = usercd.address
        now = datetime.datetime.now()
        birth =  usercd.birthDate
        age = now.year - birth.year
        return render(request, 'account/user1.html', {'usercd':usercd, 'address':address, 'age':age})
    else:
        return HttpResponseRedirect('/register/')

class UserCdUpdate(UpdateView):
    model = UserCd
    form_class = UserCdForm
    template_name = 'account/user2.html'
    success_url = '..'

    def get_object(self):
        return UserCd.objects.get(pk=self.request.user.pk)  # or request.POST


class AddressUpdate(UpdateView):
    model = Address
    form_class = AddressForm
    template_name = 'account/user2.html'
    success_url = '..'

    def get_object(self):
        usercd = UserCd.objects.get(pk=self.request.user.pk)
        return usercd.address

class UserUpdate(UpdateView):
    model = User
    form_class = UserForm
    template_name = 'account/user2.html'
    success_url = '..'

    def get_object(self):
        return self.request.user

    def get_form(self):
        form = FormMixin.get_form(self)
        form.fields.pop('username')
        form.fields.pop('email')
        return form

