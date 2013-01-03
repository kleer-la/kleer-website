Feature: Backward Compatibility for 404 URIs

	Scenario: Introducción a Scrum (/entrenamos/introduccion-a-scrum)
		Given I visit the former Introducción a Scrum Page
		Then I should get a 404 error
		And I should see "Hemos movido la información sobre el curso "
		And I should see "Introducción a Scrum"
		And I should see "Por favor, verifica nuestro calendario para ver los detalles de dicho curso"
		And I should see a link to "/entrenamos" with text "Ver Calendario de Cursos >>"
		
	Scenario: Introducción a Scrum en Español (/es/entrenamos/introduccion-a-scrum)
		Given I visit the former Introducción a Scrum spanish Page
		Then I should get a 404 error
		And I should see "Hemos movido la información sobre el curso "
		And I should see "Introducción a Scrum"
		And I should see "Por favor, verifica nuestro calendario para ver los detalles de dicho curso"
		And I should see a link to "/entrenamos" with text "Ver Calendario de Cursos >>"
		
	Scenario: Desarrollo Ágil de Software (/entrenamos/desarrollo-agil-de-software)
		Given I visit the former Desarrollo Agil Page
		Then I should get a 404 error
		And I should see "Hemos movido la información sobre el curso "
		And I should see "Desarrollo Ágil de Software"
		And I should see "Por favor, verifica nuestro calendario para ver los detalles de dicho curso"
		And I should see a link to "/entrenamos" with text "Ver Calendario de Cursos >>"

	Scenario: Desarrollo Ágil de Software en Español (/es/entrenamos/desarrollo-agil-de-software)
		Given I visit the former Desarrollo Agil spanish Page
		Then I should get a 404 error
		And I should see "Hemos movido la información sobre el curso "
		And I should see "Desarrollo Ágil de Software"
		And I should see "Por favor, verifica nuestro calendario para ver los detalles de dicho curso"
		And I should see a link to "/entrenamos" with text "Ver Calendario de Cursos >>"
		
	Scenario: Introducción a Scrum (/entrenamos/estimacion-y-planificacion-con-scrum)
		Given I visit the former Estimación y Planificación con Scrum Page
		Then I should get a 404 error
		And I should see "Hemos movido la información sobre el curso "
		And I should see "Análisis, Estimación y Planificación con Scrum"
		And I should see "Por favor, verifica nuestro calendario para ver los detalles de dicho curso"
		And I should see a link to "/entrenamos" with text "Ver Calendario de Cursos >>"

	Scenario: Introducción a Scrum (/es/entrenamos/estimacion-y-planificacion-con-scrum)
		Given I visit the former Estimación y Planificación con Scrum spanish Page
		Then I should get a 404 error
		And I should see "Hemos movido la información sobre el curso "
		And I should see "Análisis, Estimación y Planificación con Scrum"
		And I should see "Por favor, verifica nuestro calendario para ver los detalles de dicho curso"
		And I should see a link to "/entrenamos" with text "Ver Calendario de Cursos >>"				