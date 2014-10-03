# encoding: utf-8

require File.join(File.dirname(__FILE__),'../lib/category')
require 'libxml'
require 'spec_helper'

describe Category do
  
  before(:each) do
    @category = Category.new
    @xml = '<?xml version="1.0" encoding="UTF-8"?>
  <category>
    <codename>high-performance</codename>
    <created-at type="datetime">2013-07-10T20:51:35Z</created-at>
    <description>una descripción...</description>
    <id type="integer">1</id>
    <name>High Performance</name>
    <order type="integer">1</order>
    <tagline>Personas, Equipos y Organizaciones Eficientes</tagline>
    <updated-at type="datetime">2013-07-10T20:51:35Z</updated-at>
    <visible type="boolean">true</visible>
    <description-en>description EN</description-en>
    <name-en>name EN</name-en>
    <tagline-en>tagline EN</tagline-en> 
  </category>
    '
  end

  it "should have a name" do
    @category.name = "pepepe"
    @category.name.should == "pepepe"
  end
  
  it "should have a codename" do
    @category.codename = "pepepe"
    @category.codename.should == "pepepe"
  end
  
  it "should have a tagline" do
    @category.tagline = "pepepe"
    @category.tagline.should == "pepepe"
  end

  it "should have a description" do
    @category.description = "pepepe"
    @category.description.should == "pepepe"
  end
  
  it "should have a order" do
    @category.order = 12
    @category.order.should == 12
  end  
  
  it "should load from XML (es)" do
    parser =  LibXML::XML::Parser.string( @xml )
    doc = parser.parse

    category = Category.new doc.find('/category')[0], "es"

    category.description.should == "una descripción..."
    category.name.should == "High Performance"
  end

  it "should load from XML (en)" do
    parser =  LibXML::XML::Parser.string( @xml )
    doc = parser.parse

    category = Category.new doc.find('/category')[0], "en"

    category.description.should == "description EN"
    category.name.should == "name EN"
    category.tagline.should == "tagline EN"
  end
end