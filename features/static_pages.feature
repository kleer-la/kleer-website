Feature: Static pages - Frequently asked questions

	Scenario: International payments page
		Given I visit the international payment page
		Then I should see "Facturación"
		And I should see "Datos de empresas y ordenantes"
		And I should see "Instrucciones para el pago"

	Scenario: CSM QnA page
		Given I visit the CSM QnA page
		Then I should see "¿Cómo puedo comparar ésta con las demás certificaciones de Scrum Alliance?"
		And I should see "¿El costo del entrenamiento incluye la certificación ante la Scrum Alliance?"
		And I should see "¿Cuál es el puntaje mínimo para aprobar el examen?"
		And I should see "¿Dónde puedo encontrar material para prepararme para el examen?"
		And I should see "¿Qué pasa si no apruebo el examen?"
		And I should see "¿Qué sigue después de certificarme como CSM?"

	Scenario: CSD QnA page
		Given I visit the CSD QnA page
		Then I should see "¿Cómo se obtiene la certificación como Scrum Developer?"
		And I should see "¿Cómo puedo comparar ésta con las demás certificaciones de Scrum Alliance?"
		And I should see "¿Si ya soy Certified Scrum Master necesito tomar los 3 Módulos?"
		And I should see "¿Si tomo el módulo 1 y el módulo 2 puedo optar por la certificación CSM?"
		And I should see "¿El costo del entrenamiento incluye la certificación ante la Scrum Alliance?"
		And I should see "¿Cuál es el puntaje mínimo para aprobar el examen?"
		And I should see "¿Que pasa si no apruebo el examen al final del entrenamiento?"

	Scenario: Argentinian payments page
		Given I visit the argentinian payment page
		Then I should see "Facturación"
		And I should see "personas físicas"
		And I should see "CUIT"

	Scenario: Colombian payments page
		Given I visit the colombian payment page
		Then I should see "Agile Spin "
		And I should see "Persona Natural"
		And I should see "NIT"
