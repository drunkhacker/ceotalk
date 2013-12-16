require 'spec_helper'

describe User do
  it "is valid with name and email" do
    @user = FactoryGirl.build :user
    @user.should be_valid
  end

  it "is not valid with empty name" do
    @user = FactoryGirl.build(:user, name: nil)
    @user.should_not be_valid
  end
end
