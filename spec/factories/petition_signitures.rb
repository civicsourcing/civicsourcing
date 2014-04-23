# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :petition_signature do
    user ""
    petition ""
    comment "MyText"
  end
end
