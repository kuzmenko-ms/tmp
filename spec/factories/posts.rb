FactoryGirl.define do
  factory :post do
    sequence(:title) {|n| "New Title -- #{n}" }
    content "MyText"
    user
  end
end
