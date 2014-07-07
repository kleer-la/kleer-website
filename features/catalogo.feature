# encoding: utf-8
Feature: Catalogo de cursos
		
	Scenario: Mostrar las categorías
		Given I visit the "catalogo" page
		Then I should see "High Performance"

    Scenario: Mostrar ratings
        Given I visit the "catalogo" page
        Then I should see a rating
