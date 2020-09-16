# -*- coding: utf-8 -*-

'''
var connectionStrings = {
    tcg: "DSN=exile_tcg",
    nexus: "DSN=exile_nexus",
    game: ""
};
'''

registration = {
    "enabled":True,
    "until":None
}

urlNexus = "https://exileng.com/"

allowedOrientations = [1,2,3]
allowedRetry = True
allowedHolidays = True

hasAdmins = False    # allow to send messages to administrators or not

maintenance = False            # enable/disable maintenance
maintenance_msg = "Maintenance serveur ..." #"Mise à jour logiciel ...";#"Maintenance serveur" #Migration de la base de donnée";

supportMail = "info@exil.pw"
senderMail = "exil.pw<invalid@exil.pw>"

'''
var adExecuteNoRecords = 128;
'''

# Players relationships constants (pas touche !)
rUninhabited = -3
rWar = -2
rHostile = -1
rFriend = 0
rAlliance = 1
rSelf = 2

# Session constant names
sUser = "user"
sPlanet = "planet"
sLastLogin = "lastlogin"
sPlanetList = "planetlist"
sPlanetListCount = "planetlistcount"
sPrivilege = "Privilege"
sLogonUserID = "logonuserid" # this is the userid when the user logged in, it won't change even if another user is impersonated

'''
// Set response codepage to UTF-8
Response.CodePage = 65001;
Response.CharSet = "utf-8";
'''