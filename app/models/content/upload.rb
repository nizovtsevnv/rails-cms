class Content::Upload < ActiveRecord::Base
  has_attached_file :attachment, :path => ":rails_root/public/static/:id.:extension", :url => "/static/:id.:extension"

  def to_param
    name
  end

  def to_s
    name
  end

  validates :attachment_file_name, :presence => true
  validates :attachment_file_size, :numericality => {:less_than => 100.megabytes}
  validates :name, :presence => true, :uniqueness => true
end
