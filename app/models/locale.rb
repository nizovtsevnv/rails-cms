class Locale < ActiveRecord::Base
  self.primary_key = :name
  
  has_many :pages, :dependent => :destroy
  
  def to_s
    name
  end

  validates :name, :presence => true, :uniqueness => true
end
