# encoding: utf-8

require File.join(File.dirname(__FILE__),'../lib/category')

describe Category do
  
  before(:each) do
    @category = Category.new
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
  
end