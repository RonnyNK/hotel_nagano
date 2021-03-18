class ReservedRoom < ActiveRecord::Base
  attr_accessible :deleted_at, :reservation_id, :room_id
end
