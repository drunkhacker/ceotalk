class FeaturedExpert < ActiveRecord::Base
  belongs_to :professional

  mount_uploader :featured_photo, FeaturedPhotoUploader
end
