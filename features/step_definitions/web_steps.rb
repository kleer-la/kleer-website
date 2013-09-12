# encoding: utf-8
require File.join(File.dirname(__FILE__),'../../lib/keventer_reader')

def stub_connector( test_file = "just_one_event.xml")
  connector = double("KeventerConnector")
  connector.stub(:events_xml_url).and_return( File.join(File.dirname(__FILE__),"../../spec/#{test_file}") )
  connector.stub(:community_events_xml_url).and_return( File.join(File.dirname(__FILE__),"../../spec/community_events.xml") )
  connector.stub(:kleerers_xml_url).and_return( File.join(File.dirname(__FILE__),"../../spec/kleerers.xml") )
  connector.stub(:categories_xml_url).and_return( File.join(File.dirname(__FILE__),"../../spec/categories.xml") )
  
  @@keventer_reader.connector = connector
end

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
  stub_connector
end

Given /^theres only one event for the following two months$/ do
  stub_connector( "just_two_events.xml")
end

Given /^there are two events$/ do
  stub_connector( "just_two_events.xml")
end

Given /^there are many events$/ do
  stub_connector( "events.xml")
end

When /^I visit the home page$/ do
  stub_connector
  visit '/'
end

Then /^I should see the json string for all of the events$/ do
  text = '\"aaData\": \[' +
            '\[\"<span class=\\\"label label-info\\\">09<br><span class=\\\"lead\\\">Ene</span></span>\",\"<a href=\\\"/entrenamos/evento/44-workshop-de-retrospectivas-buenos-aires\\\">Workshop de Retrospectivas</a><br/><img src=\\\"/img/flags/ar.png\\\"/> Buenos Aires, Argentina\",\"<a href=\\\"https://eventioz.com.ar/retrospectivas-9-ene-2012/registrations/new\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\],' +
            '\[\"<span class=\\\"label label-info\\\">31<br><span class=\\\"lead\\\">Ene</span></span>\",\"<a href=\\\"/entrenamos/evento/47-certified-scrummaster-\(csm\)-lima\\\">Certified ScrumMaster \(CSM\)</a><br/><img src=\\\"/img/flags/pe.png\\\"/> Lima, Peru\",\"<a href=\\\"http://www.openedgetech.com/calendario\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\]' +
          '\]'
  last_response.body.should =~ /#{text}/m
end

Then /^I should see the json string for the Argentina events$/ do
  text = '\"aaData\": \[' +
            '\[\"<span class=\\\"label label-info\\\">09<br><span class=\\\"lead\\\">Ene</span></span>\",\"<a href=\\\"/entrenamos/evento/44-workshop-de-retrospectivas-buenos-aires\\\">Workshop de Retrospectivas</a><br/><img src=\\\"/img/flags/ar.png\\\"/> Buenos Aires, Argentina\",\"<a href=\\\"https://eventioz.com.ar/retrospectivas-9-ene-2012/registrations/new\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\]' +
          '\]'
  last_response.body.should =~ /#{text}/m
end

Then /^I should see the json string for the Bolivia events$/ do
  # text = '\"aaData\": \[' +
  #          '\[\"<span class=\\\"label label-info\\\">09<br><span class=\\\"lead\\\">Ene</span></span>\",\"<a href=\\\"/entrenamos/evento/44-workshop-de-retrospectivas-buenos-aires\\\">Workshop de Retrospectivas</a><br/><img src=\\\"/img/flags/ar.png\\\"/> Buenos Aires, Argentina\",\"<a href=\\\"https://eventioz.com.ar/retrospectivas-9-ene-2012/registrations/new\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\],' +
  #          '\[\"<span class=\\\"label label-info\\\">16<br><span class=\\\"lead\\\">Ene</span></span>\",\"<a href=\\\"/entrenamos/evento/48-comunicacion-efectiva-en-proyectos-de-software-webinar\\\">Comunicacion Efectiva en Proyectos de Software</a><br/><img src=\\\"/img/flags/ol.png\\\"/> Webinar, -- OnLine --\",\"<a href=\\\"https://eventioz.com.ar/webinar-com-efectiva-16-ene/registrations/new\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\],' +
  #          '\[\"<span class=\\\"label label-info\\\">23<br><span class=\\\"lead\\\">Ene</span></span>\",\"<a href=\\\"/entrenamos/evento/58-webinar-de-tdd-intermedio-webinar\\\">Webinar de TDD Intermedio</a><br/><img src=\\\"/img/flags/ol.png\\\"/> Webinar, -- OnLine --\",\"<a href=\\\"https://eventioz.com.ar/web-tdd1-201301\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\],' +
  #          '\[\"<span class=\\\"label label-info\\\">24<br><span class=\\\"lead\\\">Ene</span></span>\",\"<a href=\\\"/entrenamos/evento/45-certified-scrummaster-\(csm\)-de-verano!-lobos,-pcia.-bs.-as.\\\">Certified ScrumMaster \(CSM\) de Verano!</a><br/><img src=\\\"/img/flags/ar.png\\\"/> Lobos, Pcia. Bs. As., Argentina\",\"<a href=\\\"https://eventioz.com.ar/csm-verano-23-24-y-25-ene/registrations/new\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\],' +
  #          '\[\"<span class=\\\"label label-info\\\">31<br><span class=\\\"lead\\\">Ene</span></span>\",\"<a href=\\\"/entrenamos/evento/47-certified-scrummaster-\(csm\)-lima\\\">Certified ScrumMaster \(CSM\)</a><br/><img src=\\\"/img/flags/pe.png\\\"/> Lima, Peru\",\"<a href=\\\"http://www.openedgetech.com/calendario\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\],' +
  #          '\[\"<span class=\\\"label label-info\\\">07<br><span class=\\\"lead\\\">Feb</span></span>\",\"<a href=\\\"/entrenamos/evento/49-certified-product-owner-\(cspo\)-buenos-aires\\\">Certified Product Owner \(CSPO\)</a><br/><img src=\\\"/img/flags/ar.png\\\"/> Buenos Aires, Argentina\",\"<a href=\\\"https://eventioz.com.ar/cspo-7-y-8-feb/registrations/new\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\],' +
  #          '\[\"<span class=\\\"label label-info\\\">19<br><span class=\\\"lead\\\">Feb</span></span>\",\"<a href=\\\"/entrenamos/evento/55-taller-con-angularjs-buenos-aires\\\">Taller con AngularJS</a><br/><img src=\\\"/img/flags/ar.png\\\"/> Buenos Aires, Argentina\",\"<a href=\\\"https://eventioz.com.ar/events/taller-de-angularjs/registrations/new\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\],' +
  #          '\[\"<span class=\\\"label label-info\\\">20<br><span class=\\\"lead\\\">Feb</span></span>\",\"<a href=\\\"/entrenamos/evento/59-webinar-de-tdd-avanzado-webinar\\\">Webinar de TDD Avanzado</a><br/><img src=\\\"/img/flags/ol.png\\\"/> Webinar, -- OnLine --\",\"<a href=\\\"https://eventioz.com.ar/web-tdd2-201302\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\],' +
  #          '\[\"<span class=\\\"label label-info\\\">21<br><span class=\\\"lead\\\">Feb</span></span>\",\"<a href=\\\"/entrenamos/evento/46-certified-scrummaster-\(csm\)-bogota\\\">Certified ScrumMaster \(CSM\)</a><br/><img src=\\\"/img/flags/co.png\\\"/> Bogota, Colombia\",\"<a href=\\\"mailto:entrenamos.colombia@kleer.la\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\],' +
  #          '\[\"<span class=\\\"label label-info\\\">07<br><span class=\\\"lead\\\">Mar</span></span>\",\"<a href=\\\"/entrenamos/evento/54-certified-scrummaster-\(csm\)-cochabamba\\\">Certified ScrumMaster \(CSM\)</a><br/><img src=\\\"/img/flags/bo.png\\\"/> Cochabamba, Bolivia\",\"<a href=\\\"https://docs.google.com/a/kleer.la/spreadsheet/viewform?formkey=dEF0Qmp2dUphN1pqRGtldFVLeGV6RXc6MA#gid=0\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\],' +
  #          '\[\"<span class=\\\"label label-info\\\">18<br><span class=\\\"lead\\\">Mar</span></span>\",\"<a href=\\\"/entrenamos/evento/50-introduccion-a-scrum-\(dia-1---csd-track\)-buenos-aires\\\">Introduccion a Scrum \(Dia 1 - CSD Track\)</a><br/><img src=\\\"/img/flags/ar.png\\\"/> Buenos Aires, Argentina\",\"<a href=\\\"https://eventioz.com.ar/intro-a-scrum-marzo-2013/registrations/new\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\],' +
  #          '\[\"<span class=\\\"label label-info\\\">18<br><span class=\\\"lead\\\">Mar</span></span>\",\"<a href=\\\"/entrenamos/evento/53-certified-scrum-developer-\(csd-track-completo\)-buenos-aires\\\">Certified Scrum Developer \(CSD Track Completo\)</a><br/><img src=\\\"/img/flags/ar.png\\\"/> Buenos Aires, Argentina\",\"<a href=\\\"https://eventioz.com.ar/csd-marzo-2013/registrations/new\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\],' +
  #          '\[\"<span class=\\\"label label-info\\\">19<br><span class=\\\"lead\\\">Mar</span></span>\",\"<a href=\\\"/entrenamos/evento/51-analisis,-estimacion-y-planificacion-con-scrum-\(dia-2---csd-track\)-buenos-aires\\\">Analisis, Estimacion y Planificacion con Scrum \(Dia 2 - CSD Track\)</a><br/><img src=\\\"/img/flags/ar.png\\\"/> Buenos Aires, Argentina\",\"<a href=\\\"https://eventioz.com.ar/analisis-estim-y-plan-con-scrum-marzo-2013/registrations/new\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\],' +
  #          '\[\"<span class=\\\"label label-info\\\">20<br><span class=\\\"lead\\\">Mar</span></span>\",\"<a href=\\\"/entrenamos/evento/52-desarrollo-Agil-de-software-\(dia-3---csd-track\)-buenos-aires\\\">Desarrollo Agil de Software \(Dia 3 - CSD Track\)</a><br/><img src=\\\"/img/flags/ar.png\\\"/> Buenos Aires, Argentina\",\"<a href=\\\"https://eventioz.com.ar/desarrollo-agil-marzo-2013/registrations/new\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\],' +
  #          '\[\"<span class=\\\"label label-info\\\">25<br><span class=\\\"lead\\\">Mar</span></span>\",\"<a href=\\\"/entrenamos/evento/56-certified-scrum-developer-\(csd-track-completo\)-santa-cruz-de-la-sierra\\\">Certified Scrum Developer \(CSD Track Completo\)</a><br/><img src=\\\"/img/flags/bo.png\\\"/> Santa Cruz de la Sierra, Bolivia\",\"<a href=\\\"https://docs.google.com/a/kleer.la/spreadsheet/viewform?formkey=dFk5ZUtrWlE5SUw2elJyNjQ3ZHR2bUE6MA#gid=0\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\],' +
  #          '\[\"<span class=\\\"label label-info\\\">01<br><span class=\\\"lead\\\">Abr</span></span>\",\"<a href=\\\"/entrenamos/evento/57-certified-scrum-developer-\(csd-track-completo\)-cochabamba\\\">Certified Scrum Developer \(CSD Track Completo\)</a><br/><img src=\\\"/img/flags/bo.png\\\"/> Cochabamba, Bolivia\",\"<a href=\\\"https://docs.google.com/a/kleer.la/spreadsheet/viewform?formkey=dFdfYlJhQzlVWG9uWk5yODRGVDcxVGc6MA#gid=0\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\]' +
  #        '\]'
  text = '\"aaData\": \[' +
           '\[\"<span class=\\\"label label-info\\\">16<br><span class=\\\"lead\\\">Ene</span></span>\",\"<a href=\\\"/entrenamos/evento/48-comunicacion-efectiva-en-proyectos-de-software-webinar\\\">Comunicacion Efectiva en Proyectos de Software</a><br/><img src=\\\"/img/flags/ol.png\\\"/> Webinar, -- OnLine --\",\"<a href=\\\"https://eventioz.com.ar/webinar-com-efectiva-16-ene/registrations/new\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\],' +
           '\[\"<span class=\\\"label label-info\\\">23<br><span class=\\\"lead\\\">Ene</span></span>\",\"<a href=\\\"/entrenamos/evento/58-webinar-de-tdd-intermedio-webinar\\\">Webinar de TDD Intermedio</a><br/><img src=\\\"/img/flags/ol.png\\\"/> Webinar, -- OnLine --\",\"<a href=\\\"https://eventioz.com.ar/web-tdd1-201301\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\],' +
           '\[\"<span class=\\\"label label-info\\\">20<br><span class=\\\"lead\\\">Feb</span></span>\",\"<a href=\\\"/entrenamos/evento/59-webinar-de-tdd-avanzado-webinar\\\">Webinar de TDD Avanzado</a><br/><img src=\\\"/img/flags/ol.png\\\"/> Webinar, -- OnLine --\",\"<a href=\\\"https://eventioz.com.ar/web-tdd2-201302\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\],' +
           '\[\"<span class=\\\"label label-info\\\">07<br><span class=\\\"lead\\\">Mar</span></span>\",\"<a href=\\\"/entrenamos/evento/54-certified-scrummaster-\(csm\)-cochabamba\\\">Certified ScrumMaster \(CSM\)</a><br/><img src=\\\"/img/flags/bo.png\\\"/> Cochabamba, Bolivia\",\"<a href=\\\"https://docs.google.com/a/kleer.la/spreadsheet/viewform?formkey=dEF0Qmp2dUphN1pqRGtldFVLeGV6RXc6MA#gid=0\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\],' +
           '\[\"<span class=\\\"label label-info\\\">25<br><span class=\\\"lead\\\">Mar</span></span>\",\"<a href=\\\"/entrenamos/evento/56-certified-scrum-developer-\(csd-track-completo\)-santa-cruz-de-la-sierra\\\">Certified Scrum Developer \(CSD Track Completo\)</a><br/><img src=\\\"/img/flags/bo.png\\\"/> Santa Cruz de la Sierra, Bolivia\",\"<a href=\\\"https://docs.google.com/a/kleer.la/spreadsheet/viewform?formkey=dFk5ZUtrWlE5SUw2elJyNjQ3ZHR2bUE6MA#gid=0\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\],' +
           '\[\"<span class=\\\"label label-info\\\">01<br><span class=\\\"lead\\\">Abr</span></span>\",\"<a href=\\\"/entrenamos/evento/57-certified-scrum-developer-\(csd-track-completo\)-cochabamba\\\">Certified Scrum Developer \(CSD Track Completo\)</a><br/><img src=\\\"/img/flags/bo.png\\\"/> Cochabamba, Bolivia\",\"<a href=\\\"https://docs.google.com/a/kleer.la/spreadsheet/viewform?formkey=dFdfYlJhQzlVWG9uWk5yODRGVDcxVGc6MA#gid=0\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\]' +
         '\]'
  last_response.body.should =~ /#{text}/m
end

Then /^I should see the json string with no events$/ do
  text = '\"aaData\": \[\]'
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

When /^I visit the community event page$/ do
  visit '/comunidad/evento/60-yoseki-coding-dojo-buenos-aires'
end

Then /^I should see the SnapEngage plugin$/ do
  response_body.should have_selector("script[type='text\/javascript']") do |element|
      element.should contain("SnapABug.setLocale(\"es\")")
      element.should contain("SnapABug.addButton(\"ab0964bc-0c2b-4b9b-8f59-b3e3cdb81b04\",\"0\",\"55%\")")
  end
end

Then /^the page title should be "(.*?)"$/ do |title_text|
  response_body.should have_selector("title") do |element|
      element.should contain(title_text)
  end
end

Given /^I visit the "(.*?)" page$/ do |page|
    stub_connector
  visit "/" + page
end

Given /^I visit the "(.*?)" categoria page$/ do |codename|
  stub_connector
  visit "/categoria/" + codename
end
# I visit the "xxx" ajax page (todos)
# I visit the "xxx" ajax page for Blabla (ba)
# I visit the "xxx" ajax page not very valid (otro)
When /^I visit the "(.*?)" ajax page ([^()]+)?\((.*?)\)$/ do |page, dummy, filter|
  visit "/" + page + "/eventos/pais/" +  filter
end

Then /^I should see a tweet button$/ do
  response_body.should have_selector("script") do |element|
    element.should contain("//platform.twitter.com/widgets.js")
    element.should contain("twitter-wjs")
  end
  response_body.should have_selector("a[href='https://twitter.com/share']") do |element|
    element.should contain("Tweet")
  end
end

Given(/^I visit the last tweet url for "(.*?)"$/) do |screen_name|
  visit "/last-tweet/#{screen_name}"
end

Then(/^I should see a tweet "(.*?)"$/) do |tweet|
  response_body.should be == tweet
end

Then /^I should see a facebook like button$/ do
  response_body.should have_selector("script") do |element|
    element.should contain("//connect.facebook.net/es_LA/all.js")
  end
  response_body.should have_selector("div[class='fb-like']")
end

Then /^I should see the Subscribe to newsletter option$/ do
  response_body.should have_selector("a[href='http://eepurl.com/tu9Xr']") do |element|
    element.should contain("Suscríbete a nuestra newsletter")
  end
end

Then /^the titles should use Dosis webfont$/ do
  response_body.should have_selector("link[href='http://fonts.googleapis.com/css?family=Dosis:600']")
  response_body.should have_selector("style") do |element|
    element.should contain("h1, h2, h3, h4, h5, h6 {font-family: 'Dosis'; font-weight: 600;}")
  end
end

Then /^I should see all countries highlited$/ do
  response_body.should have_selector("ul[id='country-filter']") do |element|
    element.should have_selector("li[class='active']") do |element|
      element.should have_selector("a") do |element|
        element.should contain("Todos")
      end
    end
  end
end

Then /^I should see a linkedin link for a Kleerer with LinkedIn$/ do
  response_body.should have_selector("a[href='http://www.linkedin.com/in/jgabardini']") do |element|
    element.should have_selector("img[src='/img/icons/linkedin.png']")
  end
end

Then /^I should not see an empty linkedin for a Kleerer without LinkedIn$/ do
  response_body.should_not have_selector("a[href='']")
end

Then /^I should see a Twitter box for a Kleerer with Twiiter$/ do
  response_body.should have_selector("div[id='jgabardini_twitter_container']") do |element|
    element.should contain("@jgabardini")
  end
end

Then /^I should not see a Twitter box for a Kleerer without twiiter$/ do
  response_body.should_not have_selector("div[id='_twitter_container']")
end

Then /^I should not see the Kleer Twitter Box$/ do
    response_body.should_not have_selector("div[id='kleer_la_twitter_container']")
end

Then /^I should see the Kleer Twitter Box$/ do
  response_body.should have_selector("div[id='kleer_la_twitter_container']") do |element|
    element.should contain("@kleer_la")
  end
end

Then /^I should get a (\d+) error$/ do |error_code|
  last_response.status.should == error_code.to_i
end

Given /^I visit the former Introducción a Scrum Page$/ do
  visit "/entrenamos/introduccion-a-scrum"
end

Given /^I visit the former Introducción a Scrum spanish Page$/ do
  visit "/es/entrenamos/introduccion-a-scrum"
end

Given /^I visit the former Desarrollo Agil Page$/ do
  visit "/entrenamos/desarrollo-agil-de-software"
end

Given /^I visit the former Desarrollo Agil spanish Page$/ do
  visit "/es/entrenamos/desarrollo-agil-de-software"
end

Given /^I visit the former Estimación y Planificación con Scrum Page$/ do
  visit "/entrenamos/estimacion-y-planificacion-con-scrum"
end

Given /^I visit the former Estimación y Planificación con Scrum spanish Page$/ do
  visit "/es/entrenamos/estimacion-y-planificacion-con-scrum"
end

Given /^I visit the itnernational payment page$/ do
  visit "/preguntas-frecuentes/facturacion-pagos-internacionales"
end

Given /^I visit the CSM QnA page$/ do
  visit "/preguntas-frecuentes/certified-scrum-master"
end

Given /^I visit the CSD QnA page$/ do
  visit "/preguntas-frecuentes/certified-scrum-developer"
end

Given /^I visit an invalid Page$/ do
  visit "/bazzzzingaaaa"
end

Given /^there are community events$/ do
  stub_connector( "events.xml")
end

Then /^I should see the json string for all of the community events$/ do
  text = '\"aaData\": \[' +
            '\[\"<span class=\\\"label label-info\\\">06<br><span class=\\\"lead\\\">Feb</span></span>\",\"<a href=\\\"/comunidad/evento/60-yoseki-coding-dojo-buenos-aires\\\">Yoseki Coding Dojo</a><br/><img src=\\\"/img/flags/ar.png\\\"/> Buenos Aires, Argentina\",\"<a href=\\\"mailto:dojo@kleer.la\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\],' +
            '\[\"<span class=\\\"label label-info\\\">14<br><span class=\\\"lead\\\">Feb</span></span>\",\"<a href=\\\"/comunidad/evento/61-yoseki-coding-dojo-lima\\\">Yoseki Coding Dojo</a><br/><img src=\\\"/img/flags/pe.png\\\"/> Lima, Peru\",\"<a href=\\\"mailto:hiroshi.hiromoto@kleer.la\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\]' +
         '\]'
  last_response.body.should =~ /#{text}/m
end

Then /^I should see the json string for the Argentina community events$/ do
  text = '\"aaData\": \[' +
            '\[\"<span class=\\\"label label-info\\\">06<br><span class=\\\"lead\\\">Feb</span></span>\",\"<a href=\\\"/comunidad/evento/60-yoseki-coding-dojo-buenos-aires\\\">Yoseki Coding Dojo</a><br/><img src=\\\"/img/flags/ar.png\\\"/> Buenos Aires, Argentina\",\"<a href=\\\"mailto:dojo@kleer.la\\\" target=\\\"_blank\\\" class=\\\"btn btn-success\\\">Registrarme!</a>\"\]' +
         '\]'
  last_response.body.should =~ /#{text}/m
end

Given /^I visit the former Yoseki Page$/ do
  visit "/comunidad/yoseki"
end

Given /^I visit the former Yoseki spanish Page$/ do
  visit "/es/comunidad/yoseki"
end

Given /^I visit the former entrenamos spanish Page$/ do
  visit "/es/entrenamos"
end

Then /^I should be redirected to entrenamos Page$/ do
  last_response.redirection?.should == true
  last_response.location.gsub("http://example.org","").should == "/entrenamos"
end

Given /^I visit the former comunidad spanish Page$/ do
  visit "/es/comunidad"
end

Then /^I should be redirected to comunidad Page$/ do
  last_response.redirection?.should == true
  last_response.location.gsub("http://example.org","").should == "/comunidad"
end

When /^I visit a non existing event page$/ do
  visit '/entrenamos/evento/1-un-evento-inexistente'
end

When /^I visit a non existing community event page$/ do
  visit '/comunidad/evento/1-un-evento-inexistente'
end

When /^I visit a non existing popup event page$/ do
  visit '/entrenamos/evento/1-un-evento-inexistente/remote'
end

Then(/^I should have a link to the "(.*?)" page$/) do |event_type_name|
  puts "a[text()='#{event_type_name}']"
  response_body.should have_selector("a[text()='#{event_type_name}']") do |element|
      element[0]["href"].should == "/cursos/1-"+ERB::Util::url_encode(event_type_name)
  end
end

Given(/^I visit an event type page$/) do
  visit '/cursos/1-x'
end
