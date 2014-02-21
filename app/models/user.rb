class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # carrierwave
  mount_uploader :profile_photo, ProfilePhotoUploader


  # relations
  has_many :comments
  belongs_to :company
  has_many :presentations
  has_many :interests
  has_many :categories, :through => :interests

  accepts_nested_attributes_for :categories
  accepts_nested_attributes_for :interests, allow_destroy: true

  validates_presence_of :name

  def self.with_omniauth(auth, signed_in_resource = nil) 
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    created = user.nil?
    unless user
      user = User.create(name: auth.extra.raw_info.name, 
                         provider: auth.provider,
                         uid: auth.uid,
                         email: auth.info.email,
                         password: Devise.friendly_token[0,20] )
    end
    [user, created]
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def has_interest?(cat_id)
    categories.any? {|c| c.id == cat_id}
  end

  def company_name
    if self.company then self.company.name else "소속없음" end
  end

end
