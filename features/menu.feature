# encoding: utf-8
Feature: Menu

  Scenario: Menu de publicaciones
    Given I visit the home page
    Then I should see a link to "/es/blog" with text "Blog"

  Scenario: Menu de facilitacion
    Given I visit the home page
    Then I should see a link to "/facilitacion" with text "Facilitación"
