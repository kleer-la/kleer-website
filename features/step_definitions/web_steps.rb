# encoding: utf-8
require File.join(File.dirname(__FILE__),'../../lib/keventer_reader')

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
  @@keventer_reader = KeventerReader.new( File.join(File.dirname(__FILE__),'../../specs/just_one_event.xml'), Date.parse("2012-12-20") )
end

Given /^theres only one event for the following two months$/ do
  @@keventer_reader = KeventerReader.new( File.join(File.dirname(__FILE__),'../../specs/just_two_events.xml'), Date.parse("2012-12-20") )
end

When /^I visit the home page$/ do
  visit '/'
end

Then /^I should see the dt_table string$/ do
  text = "\\[\\[\\'<span class=\\\"label label-info\\\">09<br><span class=\\\"lead\\\">Ene</span></span>\\',\\' <a data-toggle=\\\"modal\\\" data-target=\\\"#myModal\\\" href=\\\"/entrenamos/evento/44/remote\\\">Workshop de Retrospectivas</a><br/><img src=\\\"/img/flags/ar\.png\\\"/> Buenos Aires\\',\\'<a href=\\\"https://eventioz.com.ar/retrospectivas-9-ene-2012/registrations/new\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\\'\\],\\];"
  last_response.body.should =~ /#{text}/m
end

When /^I visit the entrenamos page$/ do
  visit '/entrenamos'
end

Then /^I should see the dt_table string for all of the events$/ do
  text = "\\[\\[\\'<span class=\\\"label label-info\\\">09<br><span class=\\\"lead\\\">Ene</span></span>\\',\\' <a data-toggle=\\\"modal\\\" data-target=\\\"#myModal\\\" href=\\\"/entrenamos/evento/44/remote\\\">Workshop de Retrospectivas</a><br/><img src=\\\"/img/flags/ar\.png\\\"/> Buenos Aires\\',\\'<a href=\\\"https://eventioz.com.ar/retrospectivas-9-ene-2012/registrations/new\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\\'\\],"
  text += "\\[\\'<span class=\\\"label label-info\\\">09<br><span class=\\\"lead\\\">Jul</span></span>\\',\\' <a data-toggle=\\\"modal\\\" data-target=\\\"#myModal\\\" href=\\\"/entrenamos/evento/45/remote\\\">Workshop de Retrospectivas</a><br/><img src=\\\"/img/flags/ar\.png\\\"/> Buenos Aires\\',\\'<a href=\\\"https://eventioz.com.ar/retrospectivas-9-ene-2012/registrations/new\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\\'\\],\\];"
  last_response.body.should =~ /#{text}/m
end

When /^I visit the plain event page$/ do
  visit '/entrenamos/evento/44/remote'
end

Then /^I should be on Entrenamos page$/ do
  current_url.should == "/entrenamos"
end

Then /^I should see a link to "(.*?)" with text "(.*?)"$/ do |url, text|
  response_body.should have_selector("a[href='#{ url }']") do |element|
      element.should contain(text)
    end
end

Then /^I should see an image pointing to "(.*?)"$/ do |url|
  response_body.should have_selector("img[src='#{ url }']")
end

When /^I visit the event page$/ do
  visit '/entrenamos/evento/44-workshop-de-retrospectivas-buenos-aires'
end



