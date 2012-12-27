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