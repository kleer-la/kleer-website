Feature: Backward Compatibility for 404 URIs

	Scenario: Introducción a Scrum (/entrenamos/introduccion-a-scrum)
		Given I visit the former Introducción a Scrum Page
		Then I should see "La información sobre el curso de '<strong>Introducción a Scrum</strong>' fue movida. Por favor, verifica nuestro calendario para ver los detalles de dicho curso"
		And It should return 404 error
		