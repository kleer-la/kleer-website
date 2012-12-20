# encoding: utf-8
Feature: Home Page

	@selenium
	Scenario: Próximos eventos
		Given theres only one event
		When I visit the home page
		Then I should see the dt_table string