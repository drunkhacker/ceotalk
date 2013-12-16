require 'spec_helper'

describe Company do
  it "is valid with name and url" do
    @company = FactoryGirl.build :company
    @company.should be_valid
  end

  it "must have members" do
    @company = FactoryGirl.build :company
    @user = FactoryGirl.build :user
    @cto = FactoryGirl.build :professional

    @user.company = @company
    @cto.company = @company

    @user.save!
    @cto.save!

    @company.members.should include(@user, @cto)
  end

  it "must be retrieved by user" do
    @company = FactoryGirl.build :company
    @user = FactoryGirl.build :user

    @user.company = @company
    @user.save!
    @company.save!

    @user.company.should eq @company 
  end
end
