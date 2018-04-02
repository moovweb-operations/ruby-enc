require 'spec_helper'

describe PuppetDB do
  it "should have options" do
    expect(PuppetDB.options).to be_kind_of Hash
  end
end
