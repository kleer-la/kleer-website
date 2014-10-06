# encoding: utf-8
Feature: Home Page

	Scenario: Currícula accesible desde la home page
		Given I visit the home page
		Then I should see a link to "http://media.kleer.la/kleer-entrenamos-2014.pdf" with text "Más Información"
		
	Scenario: Datos de contacto
		Given I visit the home page
		Then I should see "ARG"
		And I should see "Lavalle 362"
		And I should see "BRA"
		And I should see "BOL"
		And I should see "COL"
		And I should see "¿Otro?"

	Scenario: Integracion con SnapEngage
		Given I visit the home page
		Then I should see the SnapEngage plugin

	Scenario: Subscripcion a newsletter
		Given I visit the home page
		Then I should see the Subscribe to newsletter option

	@wip
	Scenario: Ajax request
		Given I visit the home page
		When I get 5 community events
		Then I should see "\"data\":"
