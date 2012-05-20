class User < ActiveRecord::Base
  has_many :memberships, :inverse_of => :user, :dependent => :destroy
  has_many :games, :through => :memberships

  attr_accessible :name, :fb_access_token

  validates :fb_user_id, :presence => true
  validates :fb_user_id, :uniqueness => true

end
