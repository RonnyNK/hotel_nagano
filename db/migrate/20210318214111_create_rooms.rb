class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :next_door
      t.integer :floor
      t.integer :view_type_id
      t.integer :room_type_id
      t.integer :base_rate_id

      t.timestamps
    end
  end
end
