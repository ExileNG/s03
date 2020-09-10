# -*- coding: utf-8 -*-

from django.conf import settings
from django.conf.urls.static import static
from django.urls import include, path
from django.views.generic.base import RedirectView



################################################################################
urlpatterns = [
	#---------------------------------------------------------------------------
	path('',                RedirectView.as_view(url='/game/')),
    #---------------------------------------------------------------------------
    path('impersonate/',    include('impersonate.urls')),
    path('game/',           include('web_game.urls')),
    #---------------------------------------------------------------------------
] \
+ static('/favicon.ico', document_root=settings.STATIC_ROOT + '/favicon.ico') \
+ static('/assets/', document_root=settings.STATIC_ROOT + '/assets') \
+ static('/scripts/', document_root=settings.STATIC_ROOT + '/scripts')
################################################################################
