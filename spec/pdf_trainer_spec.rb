# encoding: utf-8

require File.join(File.dirname(__FILE__),'../lib/pdf_trainers')


describe "cuanto_dura" do
  it "should return empty when 0" do
    expect(cuanto_dura(0)).to eq ""
  end

  it "should return '1 día' when 1" do
    expect(cuanto_dura(1)).to eq "1 día"
  end

  it "should return '5 días' when 5" do
    expect(cuanto_dura(5)).to eq "5 días"
  end

  it "should return '6 horas' when 6" do
    expect(cuanto_dura(6)).to eq "6 horas"
  end

end
