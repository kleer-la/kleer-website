#encoding: utf-8

require File.join(File.dirname(__FILE__),'../lib/toggle')


describe Toggle do
  it "should have a unknow feature disabled" do
    expect(Toggle.on?("my_feature")).to be false
  end
  it "should have a turned-on feature enabled" do
    Toggle.turn("my_feature", true)
    expect(Toggle.on?("my_feature")).to be true
  end
  it "should have a turned-off feature disabled" do
    Toggle.turn("my_feature", false)
    expect(Toggle.on?("my_feature")).to be false
  end
end