# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fund do
    admin_approved false
    goal "9.99"
    end_date "2014-04-16 13:35:12"
    body "MyText"
    title "MyString"
    initiative_id 1
    total_donations "9.99"
  end
end
