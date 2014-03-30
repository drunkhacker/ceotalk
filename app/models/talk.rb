require 'video_embed'
require 'viewcountable.rb'
require 'likeable'
class Talk < ActiveRecord::Base

  belongs_to :professional
  belongs_to :category
  has_many :comments, :as => :commentable
  has_many :tags, :as => :taggable
  has_many :categories, :through => :tags

  validates_presence_of :url
  validates_presence_of :description
  validates_presence_of :professional_id

  include ::VideoEmbeddable
  include ::Likeable
  include ::Favorable
  include ::ViewCountable

  def category_names(separator=" / ")
    categories.map {|c| c.name}.join separator
  end

  def class_name
    "Talk"
  end

  def self.notify_updated_talks(t1=nil, t2= nil)
    t1 = "12:00 pm" if t1.nil?
    t2 = "12:00 pm" if t2.nil?

    t1 = Time.parse(t1, Time.now.yesterday) 
    t2 = Time.parse(t2, Time.now)

    comments = 
      Comment.where(
        "#{Comment.table_name}.created_at >= ? AND #{Comment.table_name}.created_at < ?", t1, t2
      ).select("""
        #{Comment.table_name}.*, 
        #{Talk.table_name}.title AS talk_title, 
        #{Talk.table_name}.professional_id AS professional_id"""
      ).joins("""
        INNER JOIN #{Talk.table_name} ON #{Comment.table_name}.commentable_id = #{Talk.table_name}.id 
        AND #{Comment.table_name}.commentable_type = '#{Talk.name}'"""
      ).order("""
        #{Comment.table_name}.commentable_id ASC,
        #{Comment.table_name}.created_at DESC"""
      )

    comments.group_by(&:professional_id).each do |professional_id, all_comments|
      talks_and_comments = all_comments.group_by(&:commentable_id).to_a.map {|talk_id, talk_comments| [Talk.find(talk_id), talk_comments]}

      videos_and_comments = talks_and_comments.select {|talk, talk_comment| talk.is_a?(Video)}
      posts_and_comments = talks_and_comments.select {|talk, talk_comment| talk.is_a?(Post)}
      # send email
      user = User.find(professional_id)
      user_comments = user.comments.where("created_at >= ? AND created_at < ?", t1, t2)
      [user, videos_and_comments, posts_and_comments, user_comments]
      CommentMailer.talk_comments_notify_email(user, videos_and_comments, posts_and_comments, user_comments).deliver
    end
  end

  def self.find_by_keyword(term)
    term = term.split(" ").map {|s| "#{s}*"}.join(" ")
    Talk.where("MATCH(title, description) AGAINST (? IN BOOLEAN MODE)", term)
  end
end
