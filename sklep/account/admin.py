from django.contrib import admin

# Register your models here.
from .models import User, UserCd, Address

admin.site.register(User)
admin.site.register(UserCd)
admin.site.register(Address)