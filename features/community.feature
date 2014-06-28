# encoding: utf-8
Feature: Sección Comunitaria

	Scenario: Country options in entrenamos page
		Given I visit the "comunidad" page
		Then I should see all countries highlited
		And I should see "Eventos Comunitarios"