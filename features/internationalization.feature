# encoding: utf-8
Feature: i18n

	Scenario: Default menu in Spanish
		Given I visit the home page
		Then I should see "Aprendas"
		And I should see "Lo hacemos para que"
		And I should see "Logres"
		And I should see "una Organización Asombrosa"
		And I should see "Productos de Calidad"
		And I should see "Clientes Felices"		
		And I should see "Leas"
		And I should see "Veas"
		And I should see "Nos Conozcas"
		And I should see "Blog"
		

	Scenario: Spanish menu
		Given I visit the spanish home page
		Then I should see "Aprendas"
		And I should see "Lo hacemos para que:"
		And I should see "Logres"
		And I should see "una Organización Asombrosa"
		And I should see "Productos de Calidad"
		And I should see "Clientes Felices"		
		And I should see "Leas"
		And I should see "Veas"
		And I should see "Nos Conozcas"
		And I should see "Blog"	
		
	Scenario: English menu
		Given I visit the english home page
		Then I should see "Learn"
		And I should see "We do it for you to:"
		And I should see "Achieve"
		And I should see "an Amazing Organization"
		And I should see "Quality Products"
		And I should see "Happy Clients"
		And I should see "Read"
		And I should see "Watch"		
		And I should see "Know us"
		And I should see "Blog"