class User < ActiveRecord::Base
  has_many :activities, :dependent => :destroy

  has_secure_password :validations => false

  def defaults
    self.state ||= 'on'
  end

  def to_s
    email
  end

  def update_token
    update_attributes :token => "#{id}_#{SecureRandom.urlsafe_base64(60)}"
  end

  before_validation :defaults, :on => :create
  after_create :update_token
  
  validates :email, :email => true, :uniqueness => true
  validates :password, :length => {:minimum => 6}, :on => :create
  validates :password, :length => {:minimum => 6}, :on => :update, :if => lambda{|o| !o.password.nil? }
  validates :state, :inclusion => {:in => ['on', 'off']}
  validates :token, :uniqueness => true
end
