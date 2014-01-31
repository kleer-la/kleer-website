Feature: Event Details

	Scenario: Evento Plano para Popup
		Given theres only one event
		When I visit the plain event page
		Then I should see "Workshop de Retrospectivas"
		And I should see "una descripción."
		And I should see "Kleer, Tucumán 373 1er Piso"
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
		And I should see "Kleer, Tucumán 373 1er Piso"
		And I should see "Buenos Aires"
		And I should see "Argentina"
#		And I should see an image pointing to "/img/flags/ar.png"
		And I should see "Raul Gorgonzola"
		And I should see "09"
		And I should see "Ene"
		
	Scenario: Detalle de Evento Comunitario
		Given there are community events
		When I visit the community event page
		Then I should see "Yoseki Coding Dojo"
		And I should see "Es una reunión donde un grupo de desarrolladores trabajan en un desafío de programación."
		And I should see "Kleer, Tucumán 373 1er Piso"
		And I should see "Buenos Aires"
		And I should see "Argentina"
#		And I should see an image pointing to "/img/flags/ar.png"
		And I should see "Ruperto Comunitario"
		And I should see "06"
		And I should see "Feb"
		
	Scenario: Detalle de Evento Inexistante
		Given theres only one event
		When I visit a non existing event page
		Then I should see "El curso que estás buscando no fue encontrado. Es probable que ya haya ocurrido o haya sido cancelado."
		And I should see "Te invitamos a visitar nuestro calendario para ver los cursos vigentes y probables nuevas fechas para el curso que estás buscando."
		And I should see a link to "/entrenamos" with text "Ver Calendario de Cursos >>"

	Scenario: Detalle de Evento Comunitario Inexistante
		Given there are community events
		When I visit a non existing community event page
		Then I should see "El evento comunitario que estás buscando no fue encontrado. Es probable que ya haya ocurrido o haya sido cancelado."
		And I should see "Te invitamos a visitar nuestro calendario para ver los eventos vigentes y probables nuevas fechas para el evento que estás buscando."
		And I should see a link to "/comunidad" with text "Ver Calendario de Eventos Comunitarios >>"

	Scenario: Detalle popup de Evento Inexistante
		Given theres only one event
		When I visit a non existing popup event page
		Then I should see "El curso que estás buscando no fue encontrado. Es probable que ya haya ocurrido o haya sido cancelado."
		And I should see "Te invitamos a visitar nuestro calendario para ver los cursos vigentes y probables nuevas fechas para el curso que estás buscando."
		And I should see a link to "/entrenamos" with text "Ver Calendario de Cursos >>"


Scenario: Condiciones especiales del evento
		Given theres only one event
		When I visit the plain event page
		Then I should see "Incluye magia shamanica Alaimica"
