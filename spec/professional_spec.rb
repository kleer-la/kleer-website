# encoding: utf-8

require 'libxml'
require 'spec_helper'
require File.join(File.dirname(__FILE__),'../lib/professional')

describe Professional do
  
  before(:each) do
    xml = '<?xml version="1.0" encoding="UTF-8"?>
  <trainer>
      <average-rating type="decimal">4.45</average-rating>
    <net-promoter-score type="integer">97</net-promoter-score>
    <surveyed-count type="integer">94</surveyed-count>
    <promoter-count type="integer">92</promoter-count>
    <bio>Mi compromiso es asistir</bio>
    <bio-en>English Bio Alaimica</bio-en>
    <country-id type="integer">9</country-id>
    <created-at type="datetime">2012-08-23T20:40:28Z</created-at>
    <gravatar-email>malaimo@gmail.com</gravatar-email>
    <id type="integer">4</id>
    <is-kleerer type="boolean">true</is-kleerer>
    <linkedin-url>http://www.linkedin.com/in/malaimo</linkedin-url>
    <name>Martín Alaimo</name>
    <twitter-username>@martinalaimo</twitter-username>
    <updated-at type="datetime">2013-01-08T12:05:21Z</updated-at>
    <gravatar-picture-url>http://www.gravatar.com/avatar/e92b3ae0ce91e1baf19a7bc62ac03297</gravatar-picture-url>
    <country>
      <created-at type="datetime">2012-04-26T11:14:40Z</created-at>
      <id type="integer">9</id>
      <iso-code>AR</iso-code>
      <name>Argentina</name>
      <updated-at type="datetime">2012-04-26T11:14:40Z</updated-at>
    </country>
  </trainer>
    '
    parser =  LibXML::XML::Parser.string xml
    doc = parser.parse

    @trainer_en = Professional.new doc.find('/trainer')[0], "en"
    @trainer_es = Professional.new doc.find('/trainer')[0], "es"

  end

  it "should initialize with defauts" do
    professional = Professional.new
    expect(professional.id).to eq("")
    expect(professional.name).to eq("")
    expect(professional.bio).to eq("")
  end

  it "should have an id" do
    @trainer_es.id.should == 4
  end
  
  it "should have a name" do
    @trainer_es.name.should == "Martín Alaimo"
  end
  
  it "should have a linkein url" do
    @trainer_es.linkedin_url.should == "http://www.linkedin.com/in/malaimo"
  end
  
  it "should have a gravatar picture" do
    @trainer_es.gravatar_picture_url.should == "http://www.gravatar.com/avatar/e92b3ae0ce91e1baf19a7bc62ac03297"
  end
  
  it "should have a twitter username" do
    @trainer_es.twitter_username.should == "@martinalaimo"
  end
  
  it "should load bio from XML (en)" do
    @trainer_en.bio.should == "English Bio Alaimica"
  end
  
  it "should load bio from XML (sp)" do
    @trainer_es.bio.should == "Mi compromiso es asistir"
  end

end