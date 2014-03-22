require 'spec_helper'

describe Community do

  context "validates" do
    before :each do
      @community = FactoryGirl.build(:community)
    end

    it "the presence of a name" do
      expect(@community).to validate_presence_of(:name)
    end

    it "that the name is between 3 and 80 characters" do
      expect(@community).to ensure_length_of(:name).is_at_least(3).
        is_at_most(80)
    end

    it "that the slug is unique" do
      expect(@community).to validate_uniqueness_of(:slug).case_insensitive
    end
  end

  context "it calculates a community's engagement rank" do
    before :each do
      @school = FactoryGirl.create(:community_category, name: "School")
      @city = FactoryGirl.create(:community_category, name: "City")
      @school1 = FactoryGirl.create(:community, community_category: @school)
      @school2 = FactoryGirl.create(:community, community_category: @school)
      @school3 = FactoryGirl.create(:community, community_category: @school)
      @city1 = FactoryGirl.create(:community, community_category: @city)
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @user3 = FactoryGirl.create(:user)
      @user1.add_points(10)
      @user2.add_points(25)
      @user3.add_points(20)
      @user1.join(@school1)
      @user2.join(@school2)
      @user3.join(@school3)
      @user1.join(@school3)
      @user1.join(@city1)
      @user2.join(@city1)
      @user3.join(@city1)
    end

    it "by comparing a community with other groups in its category" do
      expect(@school3.engagement_rank).to eq 1
      expect(@school2.engagement_rank).to eq 2
      expect(@school1.engagement_rank).to eq 3
    end

  end

end
