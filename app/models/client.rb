class Client < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name
  has_many :reservations
  has_many :reserved_rooms, :through => :reservations
  validates :email, :first_name, :last_name, presence: true
  scope :with_reservations, -> { joins(:reservations)}
  def full_name
    "#{first_name} #{last_name}"
  end
end
