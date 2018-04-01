require 'spec_helper'

describe Parameter do
  it "has a valid factory" do
    FactoryBot.create(:parameter).should be_valid
  end

  it "is invalid without a key" do
    FactoryBot.build(:parameter, key: nil).should_not be_valid
  end

  it "is invalid without a value" do
    FactoryBot.build(:parameter, value: nil).should_not be_valid
  end
end
