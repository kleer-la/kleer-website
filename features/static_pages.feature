Feature: Static pages - Frequently asked questions

	Scenario: International payments page
		Given I visit the itnernational payment page
		Then I should see "Facturación"
		And I should see "Datos de empresas y ordenantes"
		And I should see "Instrucciones para el pago"
