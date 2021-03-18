class CreateDayRates < ActiveRecord::Migration
  def change
    create_table :day_rates do |t|
      t.string :name
      t.decimal :rate

      t.timestamps
    end
  end
end
