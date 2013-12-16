class Category < ActiveRecord::Base
  belongs_to :parent, :class_name => "Category"
  has_many :children, :foreign_key => "parent_id", :class_name => "Category"
  validates_presence_of :name

  def self.roots
    Category.where(:parent_id => nil)
  end
end
