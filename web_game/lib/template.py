# -*- coding: utf-8 -*-

from web_game.lib.functions import *

template_addsessioninfo=True

class TemplaceContext():
    
    def __init__(self):
        self.LCID = ""
        self.template = ""
        
        self.data = {}

    def AssignValue(self, key, value):
        self.data[key] = value
    
    def Parse(self, key):
        self.data[key] = True
        
# Return an initialized template
def GetTemplate(request, name):
    result = TemplaceContext()
    '''
    result.TrimWhiteSpaces = true
    
    on error resume next
    err.clear
    result.Load Server.MapPath("templates\" & Session.LCID & "\" & name & ".html")
    if err.number <> 0 then result.Load Server.MapPath("templates\" & name & ".html")
    on error goto 0
    '''
    result.template = name + ".html"

    if template_addsessioninfo:
        # set LCID to the current session LCID
        result.LCID = request.session.get("LCID")
        result.AssignValue("LCID", request.session.get("LCID"))
        result.AssignValue("sessionid", request.session.get("SessionID"))

    result.AssignValue("PATH_IMAGES", "/assets/")
    result.AssignValue("PATH_TEMPLATE", "/game/templates")

    return result