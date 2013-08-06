#encoding: utf-8

Feature: Twitter box

	Scenario: Home Page Twitter
		Given I visit the home page
		Then I should see the Kleer Twitter Box
	
	Scenario: Entrenamos Twitter
		Given I visit the "entrenamos" page
		Then I should see the Kleer Twitter Box
		
	Scenario: Publicamos Twitter
		Given I visit the "publicamos" page
		Then I should see the Kleer Twitter Box
	
	Scenario: Acompañamos Twitter
		Given I visit the "acompanamos" page
		Then I should see the Kleer Twitter Box
		
	Scenario: Comunidad Twitter
		Given I visit the "comunidad" page
		Then I should see the Kleer Twitter Box		

	Scenario: Somos Twitter
		Given I visit the "somos" page
		Then I should see the Kleer Twitter Box
	
	Scenario: Detalle de Evento Twitter
		Given theres only one event
		When I visit the event page
		Then I should see the Kleer Twitter Box

	Scenario: Ultimo tweet de kleer_la
		Given I visit the last tweet url for "kleer_la"
		Then I should see a tweet
	
	Scenario: Ultimo tweet para una cuenta invalida
		Given I visit the last tweet url for "esta_cuenta_no_existe"
		Then I should see a tweet
