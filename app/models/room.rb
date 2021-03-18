class Room < ActiveRecord::Base
  attr_accessible :base_rate_id, :floor, :name, :next_door, :room_type_id, :view_type_id
end
