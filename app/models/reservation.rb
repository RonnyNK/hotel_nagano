class Reservation < ActiveRecord::Base
  attr_accessible :client_id, :date_in, :date_out, :demands, :reserved_at
end
