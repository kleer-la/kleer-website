# encoding: utf-8
Feature: Sección Comunitaria

	Scenario: Country options in entrenamos page
		Given I visit the "comunidad" page
		Then I should see all countries highlited
		And I should see "Eventos Comunitarios"

#	Scenario: Próximos eventos (todos)
#		Given there are community events
#		When I visit the "comunidad" ajax page (todos)
#		Then I should see the json string for all of the community events
		
#	Scenario: Codigo de pais de Argentina (ar)
#		Given there are community events
#		When I visit the "comunidad" ajax page for Argentina (ar)
#		Then I should see the json string for the Argentina community events

#	Scenario: Codigo de pais erroneo
#		Given there are community events
#		When I visit the "comunidad" ajax page for an invalid country (invalido)
#		Then I should see the json string for all of the community events
