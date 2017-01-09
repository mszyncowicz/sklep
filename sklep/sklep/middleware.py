from django.contrib.auth import logout
from django.utils.deprecation import MiddlewareMixin

class ActiveUserMiddleware(MiddlewareMixin):
    def logUserOut(self, request):
        if request.method == 'GET':
            log_out = request.GET.getlist('logout')
            if len(log_out) > 0 and log_out[0] == '1':
                logout(request)