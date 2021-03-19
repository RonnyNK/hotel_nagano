class Billing < ActiveRecord::Base
  attr_accessible :reservation_id, :total_amount
  has_one :reservation
end
