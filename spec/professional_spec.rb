# encoding: utf-8

require 'libxml'
require 'spec_helper'
require File.join(File.dirname(__FILE__),'../lib/professional')

describe Professional do
  
  before(:each) do
    @professional = Professional.new
  end

  it "should have an id" do
    @professional.id = 12
    @professional.id.should == 12
  end
  
  it "should have a name" do
    @professional.name = "Juan"
    @professional.name.should == "Juan"
  end
  
  it "should have a bio" do
    @professional.bio = "una Bio"
    @professional.bio.should == "una Bio"
  end
  
  it "should have a linkein url" do
    @professional.linkedin_url = "path_a_profile_linkedin"
    @professional.linkedin_url.should == "path_a_profile_linkedin"
  end
  
  it "should have a gravatar picture" do
    @professional.gravatar_picture_url = "path_to_a_gravatar_picture"
    @professional.gravatar_picture_url.should == "path_to_a_gravatar_picture"
  end
  
  it "should have a twitter username" do
    @professional.twitter_username = "@pedrito"
    @professional.twitter_username.should == "@pedrito"
  end
  
end