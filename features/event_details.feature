Feature: Event Details

	Scenario: Evento Plano para Popup
		Given theres only one event
		When I visit the plain event page
		Then I should see "Workshop de Retrospectivas"
		And I should see "una descripción."
		And I should see "Buenos Aires"
		And I should see "Argentina"
		And I should see an image pointing to "/img/flags/ar.png"
		And I should see "Raul Gorgonzola"
		And I should see "09"
		And I should see "Ene"
	
	Scenario: Detalle de Evento
		Given theres only one event
		When I visit the event page
		Then I should see "Workshop de Retrospectivas"
		And I should see "una descripción."
		And I should see "Buenos Aires"
		And I should see "Argentina"
		And I should see an image pointing to "/img/flags/ar.png"
		And I should see "Raul Gorgonzola"
		And I should see "09"
		And I should see "Ene"
		
	Scenario: Detalle de Evento
		Given there are community events
		When I visit the community event page
		Then I should see "Yoseki Coding Dojo"
		And I should see "Es una reunión donde un grupo de desarrolladores trabajan en un desafío de programación."
		And I should see "Buenos Aires"
		And I should see "Argentina"
		And I should see an image pointing to "/img/flags/ar.png"
		And I should see "Ruperto Comunitario"
		And I should see "06"
		And I should see "Feb"