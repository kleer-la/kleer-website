# encoding: utf-8
Feature: Home Page

	Scenario: Currícula accesible desde la home page
		Given I visit the home page
		Then I should see a link to "/catalogo" with text "Más Información"

	Scenario: Datos de contacto
		Given I visit the home page
		Then I should see "AR"
		And I should see "Lavalle 362"
		And I should see "BR"
		And I should see "BO"
		And I should see "CO"
		And I should see "PE"
		And I should see "UY"
		And I should see "¿Otro?"

	Scenario: Integracion con SnapEngage
		Given I visit the home page
		Then I should see the SnapEngage plugin

	Scenario: Subscripcion a newsletter
		Given I visit the home page
		Then I should see the Subscribe to newsletter option

	Scenario: Ajax request
		Given I visit the home page
		When I get 5 community events
		Then I should see "\"data\":"
