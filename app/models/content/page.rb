class Content::Page < ActiveRecord::Base
  belongs_to :locale, :foreign_key => :locale_name

  scope :localized, lambda{|value| where(:locale_name => value) }
  scope :on, -> {where(:state => 'on')}
  
  def to_param
    name
  end
  
  def to_s
    title
  end

  before_validation lambda{
    self.state ||= 'off'
  }, :on => :create

  validates :locale, :presence => true
  validates :name, :presence => true, :uniqueness => true
  validates :state, :inclusion => {:in => ['off', 'on']}
end
