class Interest < ActiveRecord::Base
  belongs_to :user
  belongs_to :expert_category

  accepts_nested_attributes_for :user
end
