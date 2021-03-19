class Client < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name
  has_many :reservations
  validates :email, first_name, last_name, presence: true
end
