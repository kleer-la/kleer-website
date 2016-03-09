#encoding: utf-8
require File.join(File.dirname(__FILE__),'../../lib/keventer_reader')

Then(/^the registration link has "(.*?)"$/) do |text|
  last_response.body.should have_selector("a.btn.btn-success") do |element|
    element.to_html.should =~ /#{text}/m
  end
end

When(/^I visit the "(.*?)" plain event page$/) do |loc|
  visit "/#{loc}/entrenamos/evento/44/remote"
end

Given(/^theres one event with subtitle$/) do
  stub_connector( "one_event_w_subtitle.xml")
end

Given(/^theres only one community event w\/cotrainer$/) do
    stub_connector_community( "one_community_event_w_cotrainer.xml")
end

When /^I visit the event page$/ do
  visit '/entrenamos/evento/44-workshop-de-retrospectivas-buenos-aires'
end

When /^I visit the community event page$/ do
  visit '/comunidad/evento/60-yoseki-coding-dojo-buenos-aires'
end

