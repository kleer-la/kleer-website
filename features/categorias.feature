Feature: Categorías (Áreas)

	Scenario: Landing de Categoría (URL)
		Given there are some categories
		When I visit the "high-performance" category page
		Then I should see "High Performance"
		And I should see "Personas, Equipos y Organizaciones Eficientes"
		And I should see "una descripción..."