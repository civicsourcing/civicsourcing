# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :community do
    name "My Community"

    factory :invalid_community do
      name nil
    end
  end
end
