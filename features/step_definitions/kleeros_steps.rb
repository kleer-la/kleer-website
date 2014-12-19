#encoding: utf-8

Then(/^Karl should speak Spanish$/) do
  response_body.should have_selector("img[src='/img/personajes/karl-creemos.png']")
end

Then(/^Marty should speak Spanish$/) do
  response_body.should have_selector("img[src='/img/personajes/vive-las-met.png']")
end

Then(/^Flora should speak Spanish$/) do
  response_body.should have_selector("img[src='/img/personajes/actividades-comunitarias.png']")
end

Then(/^Karl should speak English$/) do
  response_body.should have_selector("img[src='/img/personajes/karl-creemos-en.png']")
end

Then(/^Marty should speak English$/) do
  response_body.should have_selector("img[src='/img/personajes/vive-las-met-en.png']")
end

Then(/^Flora should speak English$/) do
  response_body.should have_selector("img[src='/img/personajes/actividades-comunitarias-en.png']")
end