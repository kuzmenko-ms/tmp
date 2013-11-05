FactoryGirl.define do
  factory :user do
  	sequence(:email) {|n| "email#{n}@abc.com" }
  	password "1234567"
  end
end