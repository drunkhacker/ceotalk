require 'likeable'
class Company < ActiveRecord::Base
  has_many :members, :class_name => "User"
  has_many :comments, :as => :commentable

  mount_uploader :logo, CompanyLogoUploader

  include ::Likeable
  include ::Favorable

end
