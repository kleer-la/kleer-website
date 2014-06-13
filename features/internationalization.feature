# encoding: utf-8
Feature: i18n

	Scenario: Default menu in Spanish
		Given I visit the home page
		Then I should see "Cursos"
		And I should see "Coaching"
		And I should see "Certificaciones"
		And I should see "Comunidad"
		And I should see "Nosotros"
		And I should see "Publicaciones"
		

	Scenario: Spanish menu
		Given I visit the spanish home page
		Then I should see "Cursos"
		And I should see "Coaching"
		And I should see "Certificaciones"
		And I should see "Comunidad"
		And I should see "Nosotros"
		And I should see "Publicaciones"	
		
	Scenario: English menu
		Given I visit the english home page
		Then I should see "Training"
		And I should see "Coaching"
		And I should see "Certifications"
		And I should see "Community"
		And I should see "We are"
		And I should see "Publishing"

	Scenario: English entrenamos
		Given I visit the english "entrenamos"
		Then I should see "All"
