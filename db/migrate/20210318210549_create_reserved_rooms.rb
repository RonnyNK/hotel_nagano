class CreateReservedRooms < ActiveRecord::Migration
  def change
    create_table :reserved_rooms do |t|
      t.integer :room_id
      t.integer :reservation_id
      t.date :deleted_at

      t.timestamps
    end
  end
end
