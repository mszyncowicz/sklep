from django.shortcuts import render,render_to_response

from django.http import HttpResponse

from django.template import loader, RequestContext

from .forms import UserCdForm,UserForm,AddressForm
# Create your views here.

def register(request):
    template = loader.get_template('account/register.html')
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
            return HttpResponse('account created')
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