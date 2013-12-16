# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :talk do
    url "http://www.youtube.com/watch?v=OdkGA_rgHRY"
    description <<-EOF
      December 12, 2013 - Jon Stewart is really getting tired of Fox News still flogging this War on Christmas nonsense, and Thursday night, he said that "shit's getting real." He took on both Gretchen Carlson and Megyn Kelly Thursday night for freaking out about a Festivus pole and black Santa. Stewart mocked Fox's "manger danger warnings" before getting to the "crazy" stuff Kelly said about why Santa is white, period. Stewart explained the historical person Santa is based on actually had a darker skin pigmentation. And on the follow-up point that Jesus was white, Stewart said, "You do know Jesus wasn't born in Bethlehem, Pennsylvania, right?"
    EOF
  end
end
