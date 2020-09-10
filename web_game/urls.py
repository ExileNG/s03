# -*- coding: utf-8 -*-

from django.urls import path
from django.views.generic import TemplateView
from django.views.generic.base import RedirectView

from web_game.game import error_500

from web_game import connect

from web_game.game import alliance
from web_game.game import alliance_create
from web_game.game import alliance_invitations
from web_game.game import alliance_manage
from web_game.game import alliance_members
from web_game.game import alliance_naps
from web_game.game import alliance_reports
from web_game.game import alliance_tributes
from web_game.game import alliance_wallet
from web_game.game import alliance_wars
from web_game.game import battle
from web_game.game import battle_view
from web_game.game import buildings
from web_game.game import chat
from web_game.game import commanders
from web_game.game import fleet
from web_game.game import fleet_trade
from web_game.game import fleet_ships
from web_game.game import fleet_split
from web_game.game import fleets
from web_game.game import fleets_handler
from web_game.game import fleets_orbiting
from web_game.game import fleets_ships_stats
from web_game.game import fleets_standby
from web_game.game import game_over
from web_game.game import help
from web_game.game import holidays
from web_game.game import invasion
from web_game.game import mails
from web_game.game import maintenance
from web_game.game import map
from web_game.game import market_buy
from web_game.game import market_sell
from web_game.game import mercenary_intelligence
from web_game.game import nation
from web_game.game import notes
from web_game.game import orbit
from web_game.game import overview
from web_game.game import options
from web_game.game import planet
from web_game.game import planets
from web_game.game import production
from web_game.game import ranking_alliances
from web_game.game import ranking_players
from web_game.game import reports
from web_game.game import research
from web_game.game import shipyard
from web_game.game import spy_report
from web_game.game import training
from web_game.game import upkeep
from web_game.game import start
from web_game.game import wait



################################################################################
handler500 = 'error_500.View'
#-------------------------------------------------------------------------------
urlpatterns = [
	#---------------------------------------------------------------------------
	path('', RedirectView.as_view(url='/game/connect/')),
    path('connect/', connect.View.as_view()),
	#---------------------------------------------------------------------------
    path('alliance-create/', alliance_create.View.as_view()),
    path('alliance-invitations/', alliance_invitations.View.as_view()),
    path('alliance-manage/', alliance_manage.View.as_view()),
    path('alliance-members/', alliance_members.View.as_view()),
    path('alliance-naps/', alliance_naps.View.as_view()),
    path('alliance-reports/', alliance_reports.View.as_view()),
    path('alliance-tributes/', alliance_tributes.View.as_view()),
    path('alliance-wallet/', alliance_wallet.View.as_view()),
    path('alliance-wars/', alliance_wars.View.as_view()),
    path('alliance/', alliance.View.as_view()),
    path('battle-view/', battle_view.View.as_view()),
    path('battle/', battle.View.as_view()),
    path('buildings/', buildings.View.as_view()),
    path('chat/', chat.View.as_view()),
    path('commanders/', commanders.View.as_view()),
    path('fleet-ships/', fleet_ships.View.as_view()),
    path('fleet-split/', fleet_split.View.as_view()),
    path('fleet-trade/', fleet_trade.View.as_view()),
    path('fleet/', fleet.View.as_view()),
    path('fleets_handler/', fleets_handler.View.as_view()),
    path('fleets-orbiting/', fleets_orbiting.View.as_view()),
    path('fleets-ships-stats/', fleets_ships_stats.View.as_view()),
    path('fleets-standby/', fleets_standby.View.as_view()),
    path('fleets/', fleets.View.as_view()),
    path('game-over/', game_over.View.as_view()),
    path('help/', help.View.as_view()),
    path('holidays/', holidays.View.as_view()),
    path('invasion/', invasion.View.as_view()),
    path('mails/', mails.View.as_view()),
    path('maintenance/', maintenance.View.as_view()),
    path('map/', map.View.as_view()),
    path('market-buy/', market_buy.View.as_view()),
    path('market-sell/', market_sell.View.as_view()),
    path('mercenary-intelligence/', mercenary_intelligence.View.as_view()),
    path('nation/', nation.View.as_view()),
    path('notes/', notes.View.as_view()),
    path('orbit/', orbit.View.as_view()),
    path('options/', options.View.as_view()),
    path('overview/', overview.View.as_view()),
    path('planets/', planets.View.as_view()),
    path('planet/', planet.View.as_view()),
    path('production/', production.View.as_view()),
    path('ranking-alliances/', ranking_alliances.View.as_view()),
    path('ranking-players/', ranking_players.View.as_view()),
    path('reports/', reports.View.as_view()),
    path('research/', research.View.as_view()),
    path('shipyard/', shipyard.View.as_view()),
    path('spy-report/', spy_report.View.as_view()),
    path('start/', start.View.as_view()),
    path('training/', training.View.as_view()),
    path('upkeep/', upkeep.View.as_view()),
    path('wait/', wait.View.as_view()),
	#---------------------------------------------------------------------------
]
################################################################################
