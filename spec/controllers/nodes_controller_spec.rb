require 'spec_helper'

describe NodesController do
  let(:node) { FactoryBot.create(:node) }

  describe "GET #index" do
    it "populates an array of nodes" do
      node
      get :index
      assigns(:nodes).should eq([node])
    end

    it "renders the #index view" do
      node
      get :index
      response.should render_template :index
    end

    it "renders json" do
      node
      get :index, format: :json
    end
  end

  ["unresponsive", "failed", "pending", "changed", "unchanged", "unreported"].each do |status|
    describe "GET ##{status}" do
      before :each do
        @node = FactoryBot.create("#{status}_node".to_sym)
      end

      it "populates an array of nodes" do
        get status.to_sym
        assigns(:nodes).should eq([@node])
      end

      it "renders the #index view" do
        get :index
        response.should render_template :index
      end
    end
  end

  describe "GET #show" do
    it "assigns the requested node to @node" do
      get :show, id: node
      assigns(:node).should eq(node)
    end

    it "renders the #show view" do
      get :show, id: node
      response.should render_template :show
    end

    it "renders json" do
      get :show, id: node, format: :json
    end
  end

  describe "GET #facts" do
    it "assigns the requested node to @node" do
      get :facts, id: node
      assigns(:node).should eq(node)
    end

    it "renders the #facts view" do
      get :facts, id: node
      response.should render_template :facts
    end
  end

  describe "GET #resources" do
    it "assigns the requested node to @node" do
      get :resources, id: node
      assigns(:node).should eq(node)
    end

    it "renders the #resources view" do
      get :resources, id: node
      response.should render_template :resources
    end
  end

  describe "GET #status_history" do
    it "assigns the requested node to @node" do
      get :status_history, id: node
      assigns(:node).should eq(node)
    end
  end

  describe "GET #resource_times" do
    context "with report" do
      let(:node) { FactoryBot.create(:node_with_all_dependents) }

      it "assigns the requested node to @node" do
        get :resource_times, id: node
        assigns(:node).should eq(node)
      end
    end

    context "without report" do
      it "assigns the requested node to @node" do
        get :resource_times, id: node
        assigns(:node).should eq(node)
      end
    end
  end

  describe "GET #new" do
    it "assigns a new node to @node" do
      get :new
      assigns(:node).should be_kind_of Node
    end

    it "renders the #new view" do
      get :new
      response.should render_template :new
    end
  end

  describe "GET #edit" do
    it "assigns the requested node to @node" do
      get :edit, id: node
      assigns(:node).should eq(node)
    end

    it "renders the #edit view" do
      get :edit, id: node
      response.should render_template :edit
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new node" do
        expect {
          post :create, node: FactoryBot.attributes_for(:node)
        }.to change(Node, :count).by(1)
      end

      it "redirects to the new node" do
        post :create, node: FactoryBot.attributes_for(:node)
        response.should redirect_to Node.last
      end
    end

    context "with invalid attributes" do
      it "does not create a new node" do
        expect {
          post :create, node: FactoryBot.attributes_for(:invalid_node)
        }.to_not change(Node, :count)
      end

      it "renders the #new view" do
        post :create, node: FactoryBot.attributes_for(:invalid_node)
        response.should render_template :new
      end
    end
  end

  describe "PUT #update" do
    before :each do
      @node = FactoryBot.create(:node, description: 'foo')
    end

    context "with valid attributes" do
      it "located the requested @node" do
        put :update, id: @node, node: FactoryBot.attributes_for(:node)
        assigns(:node).should eq(@node)
      end

      it "changes @node's attributes" do
        put :update, id: @node, 
          node: FactoryBot.attributes_for(:node, description: 'bar')
        @node.reload
        @node.description.should eq('bar')
      end

      it "redirects to show new node" do
        put :update, id: @node, node: FactoryBot.attributes_for(:node)
        response.should redirect_to Node.last
      end
    end

    context "with invalid attributes" do
      it "located the requested @node" do
        put :update, id: @node, node: FactoryBot.attributes_for(:invalid_node)
        assigns(:node).should eq(@node)
      end

      it "does not change @node's attributes" do
        put :update, id: @node, 
          node: FactoryBot.attributes_for(:invalid_node, description: 'bar')
        @node.reload
        @node.description.should eq('foo')
      end

      it "renders the #edit view" do
        put :update, id: @node, node: FactoryBot.attributes_for(:invalid_node)
        response.should render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the node" do
      node
      expect {
        delete :destroy, id: node
      }.to change(Node, :count).by(-1)
    end

    it "redirects back to #index" do
      delete :destroy, id: node
      response.should redirect_to nodes_path
    end
  end
end
