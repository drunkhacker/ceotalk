# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "drh@wafflestudio.com"
    password "123123123"
    password_confirmation { "123123123" }
    name "한재화"
  end
end
