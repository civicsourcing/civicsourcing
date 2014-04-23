# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fund_reward do
    fund_id 1
    minimum_donation "9.99"
    description "MyText"
    limit 1
    taken 1
  end
end
