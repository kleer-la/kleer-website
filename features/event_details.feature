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

	Scenario: Detalle de Evento sin cotrainer
		Given theres only one event
		When I visit the event page
		Then I should see "Workshop de Retrospectivas"
		And I should see "una descripción."
		And I should see "Kleer, Tucumán 373 1er Piso"
		And I should see "Buenos Aires"
		And I should see "Argentina"
		And I should see "Facilitador:"
		And I should see "Raul Gorgonzola"
		And I should see "09"
		And I should see "Ene"
		And I should see "un texto a resaltar"

	Scenario: Detalle de Evento con cotrainer
		Given theres only one event for the following two months
		When I visit the event page
		Then I should see "Workshop de Retrospectivas"
		And I should see "Martín Alaimo"
		And I should see "Pablitux"

	Scenario: Community event w/3 facilitators
		Given theres only one community event w/cotrainer
		When I visit the community event page
		Then I should see "Mañana tengo una retrospectiva"
		And I should see "Juan Gabardini"
		And I should see "Thomas Wallet"
		And I should see "Hiroshi Hiromoto"

	Scenario: Community event w/3 facilitators in a phone
		Given theres only one community event w/cotrainer
		When I visit the community event page
		Then I should see "Mañana tengo una retrospectiva"
		And I should see "Juan Gabardini" in a phone
		And I should see "Thomas Wallet" in a phone
		And I should see "Hiroshi Hiromoto" in a phone

	Scenario: Los Eventos normales tienen sección de Experiencia Kleer
		Given theres only one event
		When I visit the event page
		Then I should see "Experiencia Kleer"

	Scenario: Detalle de Evento Comunitario
		Given there are community events
		When I visit the community event page
		Then I should see "Yoseki Coding Dojo"
		And I should see "Es una reunión donde un grupo de desarrolladores trabajan en un desafío de programación."
		And I should see "Kleer, Tucumán 373 1er Piso"
		And I should see "Buenos Aires"
		And I should see "Argentina"
		And I should see "Ruperto Comunitario"
		And I should see "06"
		And I should see "Feb"

	Scenario: Los Eventos Comunitarios no tienen sección de Experiencia Kleer
		Given there are community events
		When I visit the community event page
		Then I should not see "Experiencia Kleer"

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

	Scenario: Registración en ingles
		Given theres only one event
		When I visit the "en" plain event page
		Then the registration link has "lang=en"

	Scenario: Eventos con subtitulo
		Given theres one event with subtitle
		When I visit the event page
		Then I should see "Subtitle"
