FactoryGirl.define do
  factory :user do
    username "Joe Smith"
    email "joe@smith.com"
    password "password"

    factory :invalid_user do
      username nil
    end
  end
end
