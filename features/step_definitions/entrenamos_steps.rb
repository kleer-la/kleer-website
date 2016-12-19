#encoding: utf-8
require File.join(File.dirname(__FILE__),'../../lib/keventer_reader')


Then(/^event list is empty$/) do
  pending # express the regexp above with the code you wish you had
  last_response.body.should have_selector("a.btn.btn-success") do |element|
    element.to_html.should =~ /#{text}/m
  end
end


