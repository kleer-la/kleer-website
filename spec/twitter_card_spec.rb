# encoding: utf-8

require File.join(File.dirname(__FILE__),'../lib/twitter_card')
require 'spec_helper'

describe TwitterCard do
  
  before(:each) do
    @twcard = TwitterCard.new
  end

  it "should have a name" do
    @twcard.title = "pepepe"
    @twcard.title.should == "pepepe"
  end
  
  it "should have a codename" do
    @twcard.description = "pepepe"
    @twcard.description.should == "pepepe"
  end
  
  it "should have a tagline" do
    @twcard.image_url = "pepepe"
    @twcard.image_url.should == "pepepe"
  end

  it "should have a description" do
    @twcard.site = "@peepepe"
    @twcard.site.should == "@peepepe"
  end
  
  it "should have a order" do
    @twcard.creator = "@peepepe"
    @twcard.creator.should == "@peepepe"
  end  
  
end