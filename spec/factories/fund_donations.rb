# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fund_donation do
    fund_id 1
    user_id 1
    fund_reward_id 1
    amount "9.99"
  end
end
