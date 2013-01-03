# encoding: utf-8
Feature: Entrenamos
		
	Scenario: Próximos eventos (todos)
		Given there are two events
		When I visit the entrenamos ajax page
		Then I should see the json string for all of the events

	Scenario: Country options in entrenamos page
		Given I visit the entrenamos page
		Then I should see all countries highlited
