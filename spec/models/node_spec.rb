require 'spec_helper'

describe Node do
  it "has a valid factory" do
    FactoryBot.create(:node).should be_valid
  end

  it "does not allow duplicate names" do
    node = FactoryBot.create(:node)
    FactoryBot.build(:node, name: node.name).should_not be_valid
  end

  it "is invalid without a name" do
    FactoryBot.build(:node, name: nil).should_not be_valid
  end

  it "returns name for to_param" do
    node = FactoryBot.create(:node)
    node.to_param.should == node.name
  end

  it "returns name for to_s" do
    node = FactoryBot.create(:node)
    node.to_s.should == node.name
  end

  context "dependents" do
    before(:each) do
      @node = FactoryBot.create(:node_with_reports)
    end

    it "deletes reports" do
      expect {
        @node.destroy
      }.to change(Report, :count).by(-5)
    end

    it "deletes report logs" do
      expect {
        @node.destroy
      }.to change(ReportLog, :count).by(-25)
    end

    it "deletes metrics" do
      expect {
        @node.destroy
      }.to change(Metric, :count).by(-25)
    end

    it "deletes resource statuses" do
      expect {
        @node.destroy
      }.to change(ResourceStatus, :count).by(-25)
    end
  end

  describe "environment" do
    subject { node.environment }

    context "when nil" do
      let(:node) { FactoryBot.create(:node, environment: nil) }
      it { should == "production" }
    end

    context "when stage" do
      let(:node) { FactoryBot.create(:node, environment: "stage") }
      it { should == "stage" }
    end
  end

  describe "collapse_parameters" do
    let(:node) { FactoryBot.create(:node, name: "mynode") }
    let(:node_group) { FactoryBot.create(:node_group, name: "mygroup") }
    let(:global_parameter) { FactoryBot.create(:parameter, key: "a", value: 0) }
    let(:node_parameter) { FactoryBot.create(:parameter, key: "a", value: 1) }
    let(:group_parameter) { FactoryBot.create(:parameter, key: "b", value: 2) }
    subject { node.collapse_parameters }

    it { should be_kind_of Hash }
    it { should == {} }

    context "with global parameters" do
      before { global_parameter }
      let(:global_parameter) { FactoryBot.create(:parameter, key: "foo", value: 0) }

      it { should == { "foo" => "0" } }

      context "with group parameters" do
        before { node.node_groups << node_group }
        before { FactoryBot.create(:parameter, parameterable_type: "NodeGroup", parameterable_id: node_group.id, key: "foo", value: 1) }

        it { should == { "foo" => "1" } }

        context "with node parameters" do
          before { FactoryBot.create(:parameter, parameterable_type: "Node", parameterable_id: node.id, key: "foo", value: 2) }

          it { should == { "foo" => "2" } }
        end
      end
    end
  end

  describe "to_hash" do
    subject { node.to_hash }

    context "node" do
      let(:node) { FactoryBot.create(:node, name: "example.com") }
      it { should == {
        "name"        => "example.com",
        "environment" => "production",
        "classes"     => [],
        "parameters"  => {}
      } }
    end

    context "node with all dependents" do
      let(:node_class1) { FactoryBot.create(:node_class, name: "myclass1") }
      let(:node_class2) { FactoryBot.create(:node_class, name: "myclass2") }
      let(:node_group) { FactoryBot.create(:node_group, name: "mygroup") }
      let(:node) { FactoryBot.create(:node, name: "example.com") }
      let(:node_parameter) { FactoryBot.create(:parameter, key: "foo", value: "bar") }
      before { node.node_classes << node_class1 }
      before { node.node_classes << node_class2 }
      before { node.node_groups << node_group }
      before { node.parameters << node_parameter }
      it { should == {
        "name"        => "example.com",
        "environment" => "production",
        "classes"     => ["myclass1", "myclass2"],
        "parameters"  => { "foo" => "bar" }
      } }
    end
  end

  describe "to_yaml" do
    let(:node) { FactoryBot.create(:node) }
    subject { node.to_yaml }
    it { should be_kind_of String }
  end
end
