class Client < ActiveRecord::Base
  attr_accessible :deleted_at, :email, :first_name, :last_name
  has_many :reservations, :dependent => :destroy
  has_many :reserved_rooms, :through => :reservations
  validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: true
  scope :not_deleted, -> {
    where(deleted_at: nil)
  }
  scope :with_reservations, -> { joins(:reservations)}
  def full_name
    "#{first_name} #{last_name}"
  end
end
