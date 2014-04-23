# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :petition do
    title "MyString"
    body "MyText"
    user ""
    goal 1
    initiative_signatures_count 1
    delivery_date "2014-04-14 13:03:09"
    deliver_to "MyString"
  end
end
