require 'spec_helper'

describe Professional do
  it "is valid with name and email" do
    @pro = FactoryGirl.build :professional
    @pro.should be_valid
  end

  it "has type of Professional" do
    @pro = FactoryGirl.build :professional
    @pro.class.should eq Professional
  end

  it "has type of User too" do
    @pro = FactoryGirl.build :professional
    (@pro.class < User).should eq true
  end
end
