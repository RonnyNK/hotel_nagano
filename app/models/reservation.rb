class Reservation < ActiveRecord::Base
  attr_accessible :client_id, :date_in, :date_out, :deleted_at, :demands, :billing_id
  belongs_to :client
  belongs_to :billing
  has_many :reserved_rooms
  has_many :rooms, :through => :reserved_rooms
  validates :client_id, :date_in, :date_out, presence: true
  scope :not_deleted, -> {
    where(deleted_at: nil)
  }
  scope :overlap, ->(date_in, date_out){
    where("? BETWEEN date_in AND date_out OR ? BETWEEN date_in AND date_out ", date_in, date_out)
  }
  scope :today, -> {
    where("? BETWEEN date_in AND date_out", Date.current)
  }
  def duration
    (date_out - date_in).to_i + 1
  end
end
