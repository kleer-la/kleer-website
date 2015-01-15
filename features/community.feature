# encoding: utf-8
Feature: Sección Comunitaria

	Scenario: Country options in entrenamos page
		Given I visit the "comunidad" page
		Then I should see all countries highlited
		And I should see "Eventos Comunitarios"

    Scenario Outline: Links a comunidades
        Given I visit the "comunidad" page
        Then <community> should have a link to <url>
    

    Examples:
        |community|url|
        | "Latinoamericana" | "http://www.agiles.org" |
        | "Argentina" | "http://www.agiles.org/argentina" |
        | "Chile" |"http://www.chileagil.cl"|
        | "Colombia" |"http://agilescolombia.org"|
        | "España" |"http://agile-spain.org"|
        | "Ecuador" |"https://www.facebook.com/AgilEcuador"|
        | "México" |"https://www.facebook.com/agilesMexico"|
        | "Paraguay" |"https://www.facebook.com/groups/agilespy"|
        | "Perú" |"https://www.facebook.com/agileperu"|
        | "Uruguay" |"http://www.agiles.org/uruguay"|
        | "Venezuela" |"http://www.agiles.org/agilven"|
