class Company < ActiveRecord::Base
  has_many :members, :class_name => "User"
  belongs_to :company_category

  mount_uploader :logo, CompanyLogoUploader

end
