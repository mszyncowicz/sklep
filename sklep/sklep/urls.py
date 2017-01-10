"""sklep URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.10/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url,include
from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.contrib.auth import views
from account.views import register,user_login,user_data,UserCdUpdate,UserUpdate,AddressUpdate
from home.views import index
from django.contrib.auth.views import logout
from product.views import product,pro
urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^register/', register, name = 'register'),
    url(r'^login/', user_login, name='login'),
    url(r'^user/dataupdate/', UserCdUpdate.as_view(), name='user_update'),
    url(r'^user/addressupdate/', AddressUpdate.as_view(), name='address_update'),
    url(r'^user/pasupdate/', UserUpdate.as_view(), name='password_update'),
    url(r'^product/(?P<product_id>[0-9]+)/$', product, name = 'product' ),
    url(r'^user/', user_data, name='user'),

    url(r'^', index, name = 'index'),

]

if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root = settings.STATIC_ROOT)
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
