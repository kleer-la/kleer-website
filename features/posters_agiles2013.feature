
Feature: Posters Agiles 2013

  Scenario Outline: Posters
	Given I visit <poster_page>
	Then I should see <poster_video>
#	And I should see <poster_image>
	And I should see <poster_pdf_download>
	

	Examples:
		|poster_page|poster_video|poster_image|poster_pdf_download|
		| "/posters/scrum" | "IWUG29VPhUA" | "poster-scrum.jpg" | "http://media.kleer.la/posters/scrum.pdf" |
		| "/posters/manifesto" | "V5LaKpjcgKQ" | "poster-manifesto.jpg" | "http://media.kleer.la/posters/manifesto.pdf" |
		| "/posters/xp" | "4nN6Gh79Yg8" | "poster-xp.jpg" | "http://media.kleer.la/posters/xp.pdf" |