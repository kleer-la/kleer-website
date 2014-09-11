# encoding: utf-8

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
		
	Scenario: Detalle de Evento experimental
		Given theres only one experimental event
		When I visit the experimental event page
		Then I should see "Tipo de Evento de Prueba"
		And I should not see "Horario"
        And I should see element "informacion"
        And I should see "¿Inversión?"
        And I should see "¿Formas de pago?"
        And I should see "¿Sitio?"
        And I should see "¿Horario?"
      And I should see a link to "http://eventos.kleer.la/events/2/participants/new?lang=es" with text "¿Inversión? ¿Formas de pago? ¿Sitio? ¿Horario?"


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
		
	Scenario: Detalle de Evento Inexistente
		Given theres only one event
		When I visit a non existing event page
		Then I should see "El curso que estás buscando no fue encontrado. Es probable que ya haya ocurrido o haya sido cancelado."
		And I should see "Te invitamos a visitar nuestro calendario para ver los cursos vigentes y probables nuevas fechas para el curso que estás buscando."
		And I should see a link to "/entrenamos" with text "Ver Calendario de Cursos >>"

	Scenario: Detalle de Evento Comunitario Inexistente
		Given there are community events
		When I visit a non existing community event page
		Then I should see "El evento comunitario que estás buscando no fue encontrado. Es probable que ya haya ocurrido o haya sido cancelado."
		And I should see "Te invitamos a visitar nuestro calendario para ver los eventos vigentes y probables nuevas fechas para el evento que estás buscando."
		And I should see a link to "/comunidad" with text "Ver Calendario de Eventos Comunitarios >>"

	Scenario: Detalle popup de Evento Inexistente
		Given theres only one event
		When I visit a non existing popup event page
		Then I should see "El curso que estás buscando no fue encontrado. Es probable que ya haya ocurrido o haya sido cancelado."
		And I should see "Te invitamos a visitar nuestro calendario para ver los cursos vigentes y probables nuevas fechas para el curso que estás buscando."
		And I should see a link to "/entrenamos" with text "Ver Calendario de Cursos >>"


	Scenario: Condiciones especiales del evento
		Given theres only one event
		When I visit the event page
		Then I should see "Unas condiciones propias del evento"


	Scenario: Registración en español
		Given theres only one event
		When I visit the plain event page
		Then the registration link has "lang=es"

	Scenario: Registración en español
		Given theres only one event
		When I visit the "en" plain event page
		Then the registration link has "lang=en"
