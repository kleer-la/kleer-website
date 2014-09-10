#encoding: utf-8

Then(/^the registration link has "(.*?)"$/) do |text|
  last_response.body.should have_selector("a.btn.btn-success") do |element|
    element.to_html.should =~ /#{text}/m
  end
end

When(/^I visit the "(.*?)" plain event page$/) do |loc|
  visit "/#{loc}/entrenamos/evento/44/remote"
end

Then(/^I should not see "(.*?)"$/) do |elementId|
  response_body.should_not have_selector("div[id='"+elementId+"']")
end

Then(/^I should see element "(.*?)"$/) do |elementId|
  response_body.should have_selector("div[id='"+elementId+"']")
end



