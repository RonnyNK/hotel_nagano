class CreateBaseRates < ActiveRecord::Migration
  def change
    create_table :base_rates do |t|
      t.decimal :rate
      t.date :date_begin

      t.timestamps
    end
  end
end
