# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :initiative do
    name "MyString"
    description "MyText"
    community_id 1
  end
end
