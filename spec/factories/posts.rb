# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    url "http://blog.drunkhacker.me/?p=329"
    description "Grunt를 활용한 웹페이지 개발환경 구축"
  end
end
