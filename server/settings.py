# -*- coding: utf-8 -*-



################################################################################
import os
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
################################################################################



################################################################################
from .confidential import *
#-------------------------------------------------------------------------------
DEBUG = False
#-------------------------------------------------------------------------------
ALLOWED_HOSTS = ['ng03.exileng.com']
#-------------------------------------------------------------------------------
ADMINS = [('Freddec', 'freddec.exileng@gmail.com')]
MANAGERS = [('Freddec', 'freddec.exileng@gmail.com')]
#-------------------------------------------------------------------------------
EMAIL_HOST = 'smtp-exileng.alwaysdata.net'
DEFAULT_FROM_EMAIL = 'freddec.exileng@gmail.com'
#-------------------------------------------------------------------------------
LOGIN_URL = 'https://exileng.com'
#-------------------------------------------------------------------------------
IMPERSONATE = { 'REDIRECT_URL': '/game/', }
################################################################################



################################################################################
INSTALLED_APPS = [
    #---------------------------------------------------------------------------
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django.contrib.humanize',
    #---------------------------------------------------------------------------
    'precise_bbcode',
    'impersonate',
    #---------------------------------------------------------------------------
    'jobs',
    'web_game',
    #---------------------------------------------------------------------------
]
################################################################################



################################################################################
MIDDLEWARE = [
    #---------------------------------------------------------------------------
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    #---------------------------------------------------------------------------
    'django.middleware.common.BrokenLinkEmailsMiddleware',
    #---------------------------------------------------------------------------
    'django.middleware.locale.LocaleMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    #---------------------------------------------------------------------------
    'impersonate.middleware.ImpersonateMiddleware',
    #---------------------------------------------------------------------------
]
################################################################################



################################################################################
ROOT_URLCONF = 'server.urls'
#-------------------------------------------------------------------------------
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'web_game/game/templates'), ],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]
#-------------------------------------------------------------------------------
WSGI_APPLICATION = 'server.wsgi.application'
#-------------------------------------------------------------------------------
SECURE_SSL_REDIRECT = True
################################################################################



################################################################################
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'exileng_db',
        'USER': DB_USER,
        'PASSWORD': DB_PASSWORD,
        'HOST': DB_HOST,
        'PORT': '',
        'ATOMIC_REQUESTS': True,
        'OPTIONS': {
            'options': '-c search_path=exile_s03,static,ng03,public'
        },
    }
}
################################################################################



################################################################################
AUTH_PASSWORD_VALIDATORS = [
    {'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator', },
    {'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator', },
    {'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator', },
    {'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator', },
]
################################################################################



################################################################################
TIME_ZONE = 'UTC'
USE_TZ = True
USE_L10N = True
USE_I10N = True
################################################################################



################################################################################
STATIC_ROOT = os.path.join(BASE_DIR, 'web_game')
################################################################################
