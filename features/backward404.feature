Feature: Backward Compatibility for 404 URIs

	Scenario: Introducción a Scrum (/entrenamos/introduccion-a-scrum)
		Given I visit the former Introducción a Scrum Page
		Then I should get a 404 error
		
	Scenario: Yoseki (/comunidad/yoseki)
		Given I visit the former Yoseki Page
		Then I should get a 404 error
		And I should see "Hemos movido la información sobre el evento comunitario "
		And I should see "Yoseki Coding Dojo"
		And I should see "Por favor, verifica nuestro calendario para ver los detalles de dicho evento"
		And I should see a link to "/comunidad" with text "Ver Calendario de Eventos Comunitarios >>"	
		
	Scenario: Yoseki Spanish (/es/comunidad/yoseki)
		Given I visit the former Yoseki spanish Page
		Then I should get a 404 error
		And I should see "Hemos movido la información sobre el evento comunitario "
		And I should see "Yoseki Coding Dojo"
		And I should see "Por favor, verifica nuestro calendario para ver los detalles de dicho evento"
		And I should see a link to "/comunidad" with text "Ver Calendario de Eventos Comunitarios >>"	
			
