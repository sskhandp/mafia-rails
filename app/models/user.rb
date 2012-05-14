class User < ActiveRecord::Base
  attr_accessible :name, :fb_access_token

  validates :fb_user_id, :presence => true
  validates :fb_user_id, :uniqueness => true
end
