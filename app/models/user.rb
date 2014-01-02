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
  #XXX : 원래 expert_category는professional에만 할당된 속성인데, 귀찮아지는게 너무 많아서 일단 여기에 둔다
  belongs_to :expert_category

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

end
