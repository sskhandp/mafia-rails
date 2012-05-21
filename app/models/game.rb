class Game < ActiveRecord::Base
  has_many :memberships, :inverse_of => :game, :dependent => :destroy
  has_many :users, :through => :memberships
  belongs_to :owner, :class_name => "User"

  attr_accessible :owner, :user, :state, :stage, :memberships

  validates :state, :presence => true
end
