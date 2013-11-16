class Activity < ActiveRecord::Base
  belongs_to :user

  def to_s
    id
  end

  validates :user, :presence => true
  validates :action, :presence => true
  validates :controller, :presence => true
  validates :ip, :presence => true
  validates :host, :presence => true
end
