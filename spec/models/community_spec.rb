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

end
