# encoding: utf-8

Feature: Data Fiscal AFIP (Argentina)

	Scenario: Data Fiscal AFIP
		Given I visit the home page
		Then I should see the Argentinian fiscal data QR
		Then I should see the Argentinian fiscal data link