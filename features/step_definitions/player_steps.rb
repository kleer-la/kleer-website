Given /^the secret code is "(.*)"$/ do |code|
  visit "/setcode/#{code}"
end

