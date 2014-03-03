require 'video_embed'
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

  def category_names(separator=" / ")
    categories.map {|c| c.name}.join separator
  end

  def class_name
    "Talk"
  end

  def self.notify_updated_talks(t1=nil, t2= nil)
    t1 = Time.parse("12:00 pm", Time.now.yesterday) if t1.nil?
    t2 = Time.parse("12:00 pm", Time.now) if t2.nil?

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
      # send email
      CommentMailer.talk_comments_notify_email(User.find(professional_id), talks_and_comments).deliver
    end
  end
end
