class Content::Widget < ActiveRecord::Base
  belongs_to :locale, :foreign_key => :locale_name
  belongs_to :page

  scope :common, -> { where(:page_id => nil) }
  scope :localized, ->(value) { where(:locale_name => value) }
  scope :for, ->(value) { where(:page_id => [nil, value.id]).order('page_id DESC').group(:page_id) }
    
  # Helper for convert list of records to hash name->body
  def self.to_hash list
    Hash[list.map{|item| [item.name, item.body]}]
  end

  def to_s
    name
  end

  validates :locale, :presence => true
  validates :name, :presence => true, :uniqueness => {:scope => [:page_id, :locale]}
end
