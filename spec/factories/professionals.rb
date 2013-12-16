# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :professional do
    email "drh@easi6.com"
    password "111222333"
    password_confirmation { "111222333" }
    name "한재화 CTO"
  end
end
