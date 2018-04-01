require 'spec_helper'

describe Metric do
  it "has a valid factory" do
    FactoryBot.create(:metric).should be_valid
  end

  it "is invalid without a report" do
    FactoryBot.build(:metric, report_id: nil).should_not be_valid
  end
end
