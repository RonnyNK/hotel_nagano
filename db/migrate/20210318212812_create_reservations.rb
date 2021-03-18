class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :client_id
      t.date :reserved_at
      t.date :date_in
      t.date :date_out
      t.text :demands

      t.timestamps
    end
  end
end
