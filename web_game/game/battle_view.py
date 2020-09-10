# -*- coding: utf-8 -*-

from django.http import HttpResponseRedirect
from django.shortcuts import render
from django.views import View

from web_game.lib.exile import *
from web_game.lib.template import *

from web_game.game.lib_battle import *

class View(ExileMixin, View):

    def dispatch(self, request, *args, **kwargs):

        response = super().pre_dispatch(request, *args, **kwargs)
        if response: return response
        
        battlekey = request.GET.get("key", "")
        if battlekey == "": return HttpResponseRedirect("/game/reports/")
        
        creator = request.GET.get("by", "")
        if creator == "": return HttpResponseRedirect("/game/reports/")
        
        fromview = request.GET.get("v", "")
        if fromview == "": return HttpResponseRedirect("/game/reports/")
        
        id = request.GET.get("id", "")
        if id == "": return HttpResponseRedirect("/game/reports/")

        oKeyRs = oConnExecute(" SELECT 1 FROM battles WHERE id="+str(id)+" AND "+dosql(battlekey)+"=MD5(key||"+dosql(creator)+") ")
        if oKeyRs == None: return HttpResponseRedirect("/game/reports/")
        
        content = FormatBattle(self, id, creator, fromview, True)
        
        content.AssignValue("skin", "s_transparent")
        content.AssignValue("timers_enabled", "false")
        content.AssignValue("server", universe)
        
        return render(self.request, content.template, content.data)
