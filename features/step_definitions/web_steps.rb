# encoding: utf-8
Given /^I open the web app$/ do
	visit '/'
end

When /^I click on "(.*)"$/ do |text|
	click_link(text)
end

Then /^I should see "(.*)"$/ do |text|
	last_response.body.should =~ /#{text}/m
end

When /^I fill "(.*)" with "(.*)"$/ do |field, value|
	fill_in(field, :with => value)
end

When /^I press "(.*)"$/ do |name|
	click_button(name)
end

Given /^theres only one event$/ do
  @@keventer_reader.load_events( File.join(File.dirname(__FILE__),'../../specs/just_one_event.xml'), Date.parse("2012-12-20") , true )
end

When /^I visit the home page$/ do
  visit '/'
end

Then /^I should see the dt_table string$/ do
  text = "\\[\\[\\'09-Jan\\',\\' <a href=\\\"http://www.kleer.la/entrenamos/evento/44\">Workshop de Retrospectivas</a><br/><img src=\\\"/img/flags/ar\.png\\\"/> Buenos Aires\\',\\'<a href=\\\"https://eventioz.com.ar/retrospectivas-9-ene-2012/registrations/new\\\" target=\\\"_blank\\\"  class=\\\"btn btn-success\\\">Registrarme!</a>\\'\\],\\];"
  last_response.body.should =~ /#{text}/m
end



