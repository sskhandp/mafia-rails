class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  attr_accessible :user, :game, :state

  validates :state, :presence => true
end
