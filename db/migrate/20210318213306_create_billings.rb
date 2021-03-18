class CreateBillings < ActiveRecord::Migration
  def change
    create_table :billings do |t|
      t.integer :reservation_id
      t.decimal :total_amount

      t.timestamps
    end
  end
end
