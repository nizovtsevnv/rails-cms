class Locale < ActiveRecord::Base
  self.primary_key = :name
  
  has_many :pages, :dependent => :destroy, :class_name => Content::Page, :foreign_key => :locale_name
  
  def to_s
    name
  end

  validates :name, :presence => true, :uniqueness => true
end
