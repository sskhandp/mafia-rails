class Game < ActiveRecord::Base
  has_many :memberships, :inverse_of => :game, :dependent => :destroy
  has_many :users, :through => :memberships
  has_one :owner, :class_name => "User"

  validates :state, :presence => true
end
