class Reservation < ActiveRecord::Base
  attr_accessible :client_id, :date_in, :date_out, :demands, :reserved_at, :billing_id
  belongs_to :client
  belongs_to :billing
  has_many :reserved_rooms
  validates :client_id, :date_in, :date_out, :reserved_at, presence: true
end
