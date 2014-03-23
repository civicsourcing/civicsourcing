# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :community_category do
    name "Community Category"

    factory :invalid_community_category do
      name nil
    end
  end
end
