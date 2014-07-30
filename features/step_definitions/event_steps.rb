#encoding: utf-8

Then(/^the registration link has "(.*?)"$/) do |text|
  last_response.body.should have_selector("a.btn.btn-success") do |element|
    element.to_html.should =~ /#{text}/m
  end
end

When(/^I visit the "(.*?)" plain event page$/) do |loc|
  visit "/#{loc}/entrenamos/evento/44/remote"
end
