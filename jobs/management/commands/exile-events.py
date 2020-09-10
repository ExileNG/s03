# -*- coding: utf_8 -*-

import time
from datetime import timedelta

from django.core.management.base import BaseCommand
from django.utils import timezone

from web_game.lib.sql import *

class Command(BaseCommand):

    def handle(self, *args, **options):
        connectDB()
        start = timezone.now()
        while timezone.now() - start < timedelta(seconds=59):
            oConnExecute("SELECT sp_execute_events()")
            time.sleep(0.5)
