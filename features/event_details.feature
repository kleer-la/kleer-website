Feature: Event Details

	Scenario: Evento Plano para Popup
		Given theres only one event
		When I visit the plain event page
		Then I should see "Workshop de Retrospectivas"
		And I should see "una descripción."