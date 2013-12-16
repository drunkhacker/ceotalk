# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
    parent_id 1
    name "MyString"
  end
end
