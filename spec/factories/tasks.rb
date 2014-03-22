# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    workroom_id 1
    name "MyString"
    completed false
  end
end
