require File.join(File.dirname(__FILE__),'../../lib/toggle')

Given(/^feature "(.*?)" is (.*?)$/) do |feature,value|
    Toggle.turn(feature, value=="on")
end
