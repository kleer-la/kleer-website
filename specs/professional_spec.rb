# encoding: utf-8

require 'libxml'
require File.join(File.dirname(__FILE__),'../lib/professional')

describe Professional do
  
  before(:each) do
    @professional = Professional.new
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
  
  it "should load the latest tweet remotly" do
    @professional.twitter_username = "@pablitux"
    @professional.last_tweet_text.should_not == ""
  end
  
  it "should return the latest tweet" do
    @professional.twitter_username = "@pablitux"
    @professional.last_tweet_url.should == "http://api.twitter.com/1/statuses/user_timeline.xml?screen_name=pablitux&count=1"
    @professional.last_tweet_url = File.join(File.dirname(__FILE__),'../specs/twitter_timeline.xml') 
    @professional.last_tweet_text.should == "Muy entusiasmado con el #VideoAgil de @kleer_la que terminamos de producir y editar hoy con @rcolusso! ... muy pronto lo verán online! :)"
  end
  
  it "should return empty tweet if failed to load" do
    @professional.last_tweet_url = "sararararasa"
    @professional.last_tweet_text.should == ""
  end
  
end