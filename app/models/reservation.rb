class Reservation < ActiveRecord::Base
  attr_accessible :client_id, :date_in, :date_out, :demands, :billing_id
  belongs_to :client
  belongs_to :billing
  has_many :reserved_rooms
  validates :client_id, :date_in, :date_out, presence: true
  scope :overlap, ->(date_in, date_out){
    where("? BETWEEN date_in AND date_out OR ? BETWEEN date_in AND date_out ", date_in, date_out)
  }
end
