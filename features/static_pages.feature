Feature: Static pages - Frequently asked questions

	Scenario: International payments page
		Given I visit the itnernational payment page
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
