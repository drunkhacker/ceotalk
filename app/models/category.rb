class Category < ActiveRecord::Base
  belongs_to :parent, :class_name => "Category"
  has_many :children, :foreign_key => "parent_id", :class_name => "Category"

  has_many :interests
  has_many :users, :through => :interests

  validates_presence_of :name

  def self.roots
    Category.where(:parent_id => nil)
  end

  def aa_breadcrumb
    r = []
    o = self
    while !o.nil? do
      r.unshift "<a href=\"#{Rails.application.routes.url_helpers.admin_category_path(o)}\">#{o.name}</a>"
      o = o.parent
    end

    Rails.logger.debug "r = #{r}"
    r.join(" &gt; ").html_safe
  end

end
