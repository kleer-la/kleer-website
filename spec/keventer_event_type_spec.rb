# encoding: utf-8

require File.join(File.dirname(__FILE__),'../lib/keventer_event_type')
require 'spec_helper'

describe KeventerEventType do

  before(:each) do
    @keventtype = KeventerEventType.new
  end

  it "should have a name" do
    @keventtype.name = "Workshop de Retrospectivas"
    @keventtype.name.should == "Workshop de Retrospectivas"
  end

  it "should have a goal" do
    @keventtype.goal = "Buenos Aires"
    @keventtype.goal.should == "Buenos Aires"
  end

  it "should have a description" do
    @keventtype.description = "Argentina"
    @keventtype.description.should == "Argentina"
  end

  it "should have a elevator_pitch" do
    @keventtype.elevator_pitch = "Argentina"
    @keventtype.elevator_pitch.should == "Argentina"
  end

  it "should have rating instance variable" do
    @keventtype.average_rating.should == 0.0
    @keventtype.net_promoter_score.should == 0
    @keventtype.surveyed_count.should == 0.0
    @keventtype.promoter_count.should == 0
  end

  it "new event_type doesn't have rate" do
    @keventtype.has_rate.should be false
  end

  it "should have rate" do
    @keventtype.average_rating = 3
    @keventtype.surveyed_count= 100
    @keventtype.has_rate.should be true
  end

  it "empty event_type doesn't have rate" do
    @keventtype.average_rating = nil
    @keventtype.surveyed_count= 100
    @keventtype.has_rate.should be false
  end


  it "should have a learnings" do
    @keventtype.learnings = "Argentina"
    @keventtype.learnings.should == "Argentina"
  end

  it "should have a takeaways" do
    @keventtype.takeaways = "Argentina"
    @keventtype.takeaways.should == "Argentina"
  end

  it "should have a program" do
    @keventtype.program = "ar"
    @keventtype.program.should == "ar"
  end

  it "should have a duration" do
    @keventtype.duration = 16
    @keventtype.duration.should == 16
  end

  it "should have some recipients" do
    @keventtype.recipients = "sdkjfhskjfhskdjf"
    @keventtype.recipients.should == "sdkjfhskjfhskdjf"
  end

  it "should have some FAQs" do
    @keventtype.faqs = "sdkjfhskjfhskdjf"
    @keventtype.faqs.should == "sdkjfhskjfhskdjf"
  end

  it "should have an empty subtitle on creatio" do
    expect(@keventtype.subtitle).to eq("")
  end

  context "Loding from xml" do
    def build_and_parse(xml_element)
      initial = %(<?xml version="1.0" encoding="UTF-8"?>
      <event-type>
        <average-rating type="decimal" nil="true"/>
        <created-at type="datetime">2014-09-27T17:34:01Z</created-at>
        <csd-eligible type="boolean">false</csd-eligible>
        <description>de tres dias</description>
        <duration type="integer">24</duration>
        <elevator-pitch>de tres dias</elevator-pitch>
        <faq></faq>
        <goal></goal>
        <id type="integer">5</id>
        <include-in-catalog type="boolean">false</include-in-catalog>
        <learnings></learnings>
        <materials></materials>
        <name>Curso de 3 días</name>
        <net-promoter-score type="integer" nil="true"/>
        <program>de tres dias</program>
        <promoter-count type="integer" nil="true"/>
        <recipients>de tres dias</recipients>
        <surveyed-count type="integer" nil="true"/>
        <tag-name></tag-name>
        <takeaways></takeaways>
        <updated-at type="datetime">2014-09-27T17:34:01Z</updated-at>
      )
      closing= "</event-type>"
      parser =  LibXML::XML::Parser.string( initial + xml_element + closing )
      doc = parser.parse
      doc.find('/event_type')
      doc
    end


    it "should load basic info: id, description & duration" do
      @keventtype.load build_and_parse("")

      expect(@keventtype.id).to eq(5)
      expect(@keventtype.name).to eq("Curso de 3 días")
      expect(@keventtype.duration).to eq(24)
    end

    it "should load an emtpy subtitle" do
      @keventtype.load build_and_parse('<subtitle type="string" nil="true"/>')

      expect(@keventtype.subtitle).to eq("")
    end

    it "should load a subtitle" do
      @keventtype.load build_and_parse('<subtitle>Good to see you!</subtitle>')

      expect(@keventtype.subtitle).to eq("Good to see you!")
    end


  end

end
