# -*- coding: utf-8 -*-

import re

#functions used in login, register, password.asp & options.asp

#validate name (alphanumeric + space), len 2-12
def isValidName(myName):

    if myName == "" or len(myName) < 2 or len(myName) > 12:
        return False
    else:
        p = re.compile("^[a-zA-Z0-9]+([ ]?[\-]?[ ]?[a-zA-Z0-9]+)*$")

        return p.match(myName)

# validate an email
def isValidEmail(myEmail):

    p = re.compile("^[\w-+]+([\.]?[\w+-]+)*@([A-Za-z\d]+?([-]*[A-Za-z\d]+)*[\.]+?)+[A-Za-z]{2,4}$")

    return p.match(myEmail)

# validate an url
def isValidURL(myURL):

    p = re.compile("^(http|https|ftp)\://([a-zA-Z0-9\.\-]+(\:[a-zA-Z0-9\.&%\$\-]+)*@)?((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])|([a-zA-Z0-9\-]+\.)*[a-zA-Z0-9\-]+\.[a-zA-Z]{2,4})(\:[0-9]+)?(/[^/][a-zA-Z0-9\.\,\?\'\\/\+&%\$#\=~_\-@]*)*$")

    return p.match(myURL)

# return if the given name if valid for a fleet, a planet
def isValidObjectName(myName):
    myName = myName.strip()

    if myName == "" or len(myName) < 2 or len(myName) > 16:
        return False
    else:
        p = re.compile("^[a-zA-Z0-9\- ]+$")

        return p.match(myName)

# return if the given name if valid for a fleet, a planet
def isValidTradeRouteName(myName):
    myName = myName.strip()

    if myName == "" or len(myName) < 2 or len(myName) > 32:
        return False
    else:
        p = re.compile("^[a-zA-Z0-9\- ]+$")

        return p.match(myName)

'''
' create a random password for the user account
function makePassword(byVal maxLen)
    
    randomize

    const letters = "abcdefghijkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789"
    dim letterslen: letterslen = len(letters)

    dim i
    dim strNewPass: strNewPass = ""

    for i = 1 to maxLen
        strNewPass = strNewPass & Mid(letters, Int(letterslen*Rnd + 1), 1)
    next

    makePassword = strNewPass
end function
'''

# send an email
def sendmail(mailfrom, mailto, subject, message):
    '''
    dim Osmtp

    sendmail = ""

    Set oSmtp = Server.CreateObject("CDO.Message")
    with oSmtp
        .From = mailfrom ' jonh doe<johndoe@mail.com>
        .To = mailto ' jonh doe<johndoe@mail.com>

        .Subject = subject
        .TextBody = message

        .Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing")=2
        .Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver")="127.0.0.1"
        .Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport")=25 
        .Configuration.Fields.Update
        
        .Fields.Update()

        On Error Resume Next
        .Send
        If Err <> 0 Then
            sendmail = "Error : "  & Err & ":" & Err.Description
        end if
 
    end with
    '''
    
'''
' retrieve url content
function get_content(url)

    dim WinHttpReq

    set WinHttpReq = CreateObject("Microsoft.XMLHTTP")
'    set WinHttpReq = CreateObject("WinHttp.WinHttpRequest.5.1")

    ' settimeout resolve, connect, send, read in milliseconds
'    WinHttpReq.SetTimeouts 500, 1000, 1000, 1000

    WinHttpReq.Open "GET", url, False

    on error resume next 

    WinHttpReq.Send()
    get_content = WinHttpReq.ResponseText
    
'    Response.Write "CP: " & WinHttpReq.Option(2)
end function

'retrieve file content
function get_file_content(file)

    dim fs, thisfile, thisline', output, counter

    file = server.mappath(file)

    Set fs = CreateObject("Scripting.FileSystemObject")
    Set thisfile = fs.OpenTextFile(file, 1, False)

'    counter=0
'    do while not thisfile.AtEndOfStream
'       counter=counter+1
'       thisline=thisfile.readline & "<br>"
'       output=output & thisline
'    loop

    get_file_content = thisfile.ReadAll

    thisfile.Close
    set thisfile=nothing
    set fs=nothing

'    get_file_content = output

end function
'''