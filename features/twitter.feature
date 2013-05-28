Feature: Page Titles

	Scenario: Home Page Twitter
		Given I visit the home page
		Then I should see the Kleer Twitter Box
	
	Scenario: Entrenamos Twitter
		Given I visit the entrenamos page
		Then I should see the Kleer Twitter Box
		
	Scenario: Publicamos Twitter
		Given I visit the publicamos page
		Then I should see the Kleer Twitter Box
	
	Scenario: Acompañamos Twitter
		Given I visit the acompañamos page
		Then I should see the Kleer Twitter Box
		
	Scenario: Comunidad Twitter
		Given I visit the comunidad page
		Then I should see the Kleer Twitter Box		

	Scenario: Somos Twitter
		Given I visit the somos page
		Then I should see the Kleer Twitter Box
	
	Scenario: Detalle de Evento Twitter
		Given theres only one event
		When I visit the event page
		Then I should see the Kleer Twitter Box