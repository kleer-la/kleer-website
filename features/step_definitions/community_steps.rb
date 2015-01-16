Then(/^"(.*?)" should have a link to "(.*?)"$/) do |country, url|
 response_body.should have_selector("a", :href => url) do |element|
    element.should contain(country)
  end
end
