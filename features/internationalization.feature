# encoding: utf-8
Feature: i18n

	Scenario: Default menu in Spanish
		Given I visit the home page
		Then I should see "Cursos"
		And I should see "Coaching"
		And I should see "Comunidad"
		And I should see "Nosotros"
		And I should see "Publicaciones"
		

	Scenario: Spanish menu
		Given I visit the spanish home page
		Then I should see "Cursos"
		And I should see "Coaching"
		And I should see "Comunidad"
		And I should see "Nosotros"
		And I should see "Publicaciones"

	Scenario: Spanish kleeros
		Given I visit the spanish home page
		Then Karl should speak Spanish
		And Marty should speak Spanish
		And Flora should speak Spanish

	Scenario: English menu
		Given I visit the english home page
		Then I should see "Courses"
		And I should see "Coaching"
		And I should see "Community"
		And I should see "We are"
		And I should see "Publishing"

	Scenario: English entrenamos
		Given I visit the english "entrenamos"
		Then I should see "All"

	Scenario: English kleeros
		Given I visit the english home page
		Then Karl should speak English
		And Marty should speak English
		And Flora should speak English

