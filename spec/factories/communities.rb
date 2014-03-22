# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :community do
    community_category
    name "My Community"

    factory :invalid_community do
      name nil
    end
  end
end
