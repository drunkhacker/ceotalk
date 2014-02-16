class Presentation < ActiveRecord::Base
  has_many :votes
  belongs_to :problem
  belongs_to :user

  validates_presence_of :url
  validates_presence_of :problem_id
  validates_presence_of :user_id

  def has_vote?(user)
    Vote.where(user_id: user.id, presentation_id: self.id).any?
  end

  def vote(user)
    created = true
    begin
      Vote.create(user_id: user.id, presentation_id: self.id)
    rescue ActiveRecord::RecordNotUnique
      created = false
    end

    self.increment! :vote_count if created
  end
end
