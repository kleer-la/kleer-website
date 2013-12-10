# encoding: utf-8
Feature: i18n

	Scenario: Default menu in Spanish
		Given I visit the home page
		Then I should see "Inicio"
		And I should see "Entrenamos"
		And I should see "Lo que podemos hacer"
		And I should see "por tu Organización"
		And I should see "por tus Productos"
		And I should see "por tus Clientes"		
		And I should see "Publicamos"
		And I should see "Somos"
		And I should see "Blog"
		

	Scenario: Spanish menu
		Given I visit the spanish home page
		Then I should see "Inicio"
		And I should see "Entrenamos"
		And I should see "Lo que podemos hacer"
		And I should see "por tu Organización"
		And I should see "por tus Productos"
		And I should see "por tus Clientes"
		And I should see "Publicamos"
		And I should see "Somos"
		And I should see "Blog"		
		
	Scenario: English menu
		Given I visit the english home page
		Then I should see "Home"
		And I should see "Training"
		And I should see "What we can do"
		And I should see "for your Organization"
		And I should see "for your Products"
		And I should see "for your Clients"
		And I should see "Publications"
		And I should see "We Are"
		And I should see "Blog"