class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :presentation

  validates_presence_of :user_id
  validates_presence_of :presentation_id
end
