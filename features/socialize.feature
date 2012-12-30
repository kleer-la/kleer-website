Feature: Page Titles

	Scenario: Detalle de Evento
		Given theres only one event
		When I visit the event page
		Then I should see a tweet button
		And I should see a facebook like button