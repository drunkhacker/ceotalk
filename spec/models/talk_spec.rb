require 'spec_helper'

describe Talk do
  it "is valid with url" do
    @cto = FactoryGirl.build :professional
    @talk = FactoryGirl.build :talk
    @cto.save!
    @talk.professional = @cto
    @talk.save!
    @talk.should be_valid
  end

  it "isn't valid without url" do
    @talk = FactoryGirl.build :talk, :url => nil
    @talk.should_not be_valid
  end
end
