# encoding: utf-8

require File.join(File.dirname(__FILE__),'../lib/twitter_reader')

describe TwitterReader do
  
  before(:each) do
    @reader = TwitterReader.new
  end

  it 'should return a tweet for the kleer_la account' do
    @reader.last_tweet('kleer_la').user_id.should == '111111111'
  end
  
end