Feature: Sección Comunitaria

	Scenario: Próximos eventos (todos)
		Given there are community events
		When I visit the community ajax page
		Then I should see the json string for all of the community events
		
	Scenario: Country options in entrenamos page
		Given I visit the community page
		Then I should see all countries highlited
		And I should see "Eventos Comunitarios"		