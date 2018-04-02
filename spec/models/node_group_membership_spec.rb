require 'spec_helper'

describe NodeGroupMembership do
  it "has a valid factory" do
    FactoryBot.create(:node_group_membership).should be_valid
  end
end
