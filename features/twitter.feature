Feature: Page Titles

	Scenario: Home Page Title
		Given I visit the home page
		Then I should not see the Kleer Twitter Box
	
	Scenario: Entrenamos Title
		Given I visit the entrenamos page
		Then I should see the Kleer Twitter Box
		
	Scenario: Publicamos Title
		Given I visit the publicamos page
		Then I should see the Kleer Twitter Box
	
	Scenario: Acompañamos Title
		Given I visit the acompañamos page
		Then I should see the Kleer Twitter Box
		
	Scenario: Comunidad Title
		Given I visit the comunidad page
		Then I should see the Kleer Twitter Box		

	Scenario: Somos Title
		Given I visit the somos page
		Then I should see the Kleer Twitter Box
	
	Scenario: Detalle de Evento
		Given theres only one event
		When I visit the event page
		Then I should see the Kleer Twitter Box