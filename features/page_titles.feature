# encoding: utf-8

Feature: Page Titles

	Scenario: Home Page Title
		Given I visit the home page
		Then the page title should be "Kleer - Agile Coaching & Training"
	
	Scenario: Entrenamos Title
		Given I visit the "entrenamos" page
		Then the page title should be "Kleer - Agile Coaching & Training | Entrenamos"
		
	Scenario: Entrenamos Title
		Given I visit the "publicamos" page
		Then the page title should be "Kleer - Agile Coaching & Training | Publicamos"
	
	Scenario: Coaching Title
		Given I visit the "coaching" page
		Then the page title should be "Kleer - Agile Coaching & Training | Coaching"	
		
	Scenario: Comunidad Title
		Given I visit the "comunidad" page
		Then the page title should be "Kleer - Agile Coaching & Training | Comunidad"	

	Scenario: Somos Title
		Given I visit the "somos" page
		Then the page title should be "Kleer - Agile Coaching & Training | Somos"
	
	Scenario: Detalle de Evento
		Given theres only one event
		When I visit the event page
		Then the page title should be "Workshop de Retrospectivas - Buenos Aires"
		
	Scenario: Landing de Categoria
		Given I visit the "high-performance" categoria page
		Then the page title should be "Kleer - Agile Coaching & Training | High Performance"