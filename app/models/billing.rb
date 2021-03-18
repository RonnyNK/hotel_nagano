class Billing < ActiveRecord::Base
  attr_accessible :reservation_id, :total_amount
end
