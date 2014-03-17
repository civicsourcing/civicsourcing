require 'spec_helper'

describe Api::V1::CommunitiesController do

  describe "GET index" do
    it "assigns all communities as @communities" do
      austin = FactoryGirl.create :community, name: "Austin"
      san_fransisco = FactoryGirl.create :community, name: "San Fransisco"
      new_york = FactoryGirl.create :community, name: "New York"
      get :index
      assigns(:communities).should eq([austin, san_fransisco, new_york])
    end
  end

  describe "GET show" do
    it "assigns the requested community as @community" do
      community = FactoryGirl.create :community
      get :show, id: community
      expect(assigns(:community)).to eq community
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Community" do
        expect {
          post :create, community: FactoryGirl.attributes_for(:community)
        }.to change(Community, :count).by(1)
      end

      it "assigns a newly created community as @community" do
        post :create, community: FactoryGirl.attributes_for(:community)
        expect(assigns(:community)).to be_a(Community)
        expect(assigns(:community)).to be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved community as @community" do
        # Trigger the behavior that occurs when invalid params are submitted
        Community.any_instance.stub(:save).and_return(false)
        post :create, community: FactoryGirl.attributes_for(:invalid_community)
        expect(assigns(:community)).to be_a_new(Community)
      end
    end
  end

  describe "PATCH update" do
    before :each do
      @community = FactoryGirl.create :community, name: "Old Name"
    end

    describe "with valid params" do
      it "locates the requested community" do
        patch :update, id: @community,
          community: FactoryGirl.attributes_for(:community)
        expect(assigns(:community)).to eq(@community)
      end

      it "updates the requested community" do
        patch :update, id: @community,
          community: FactoryGirl.attributes_for(:community, name: "New Name")
        @community.reload
        expect(@community.name).to eq("New Name")
      end
    end

    describe "with invalid params" do
      it "does not change the community's attributes" do
        patch :update, id: @community,
          community: FactoryGirl.attributes_for(:invalid_community)
        @community.reload
        expect(@community.name).to eq("Old Name")
      end
    end
  end

  describe "DELETE destroy" do
    before :each do
      @community = FactoryGirl.create(:community)
    end

    it "deletes the community" do
      expect{
        delete :destroy, id: @community
      }.to change(Community, :count).by(-1)
    end
  end

end
