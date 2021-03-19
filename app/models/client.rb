class Client < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name
  has_many :reservations
  validates :email, :presence => true
  validates :first_name, :presence => true
  validates :last_name, :presence => true
end
