Feature: Somos Page

	Scenario: Somos
		Given I visit the somos page
		Then I should see "Somos"
		And I should see "Martín Alaimo"
		And I should see "@martinalaimo"
		And I should see a linkedin link for a Kleerer with LinkedIn
		And I should not see an empty linkedin for a Kleerer without LinkedIn
		And I should see a Twitter box for a Kleerer with Twiiter
		And I should not see a Twitter box for a Kleerer without twiiter