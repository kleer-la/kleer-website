# encoding: utf-8
Feature: Home Page

	Scenario: Próximos eventos
		Given theres only one event
		When I visit the home page
		Then I should see the dt_table string
		
	Scenario: Próximos eventos
		Given theres only one event for the following two months
		When I visit the home page
		Then I should see the dt_table string
		
	Scenario: Currícula accesible desde la home page
		Given I visit the home page
		Then I should see a link to "http://media.kleer.la/kleer-entrenamos-2013.pdf" with text "Información de Cursos In-Company"
		
	Scenario: Calendario 2013 accesible desde la home page
		Given I visit the home page
		When I click on "Ver Calendario 2013"
		Then I should be on Entrenamos page

	Scenario: Calendario 2013 accesible desde la home page
		Given I visit the home page
		When I click on "Ver Calendario 2013"
		Then I should be on Entrenamos page		

	Scenario: Datos de contacto
		Given I visit the home page
		Then I should see "Argentina"
		And I should see "Brasil"
		And I should see "Bolivia"
		And I should see "Colombia"
		And I should see "Perú"
		And I should see "¿Otro país?"
