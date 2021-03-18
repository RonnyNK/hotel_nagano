class CreateSeasonRates < ActiveRecord::Migration
  def change
    create_table :season_rates do |t|
      t.string :name
      t.decimal :rate
      t.date :from_date
      t.date :to_date

      t.timestamps
    end
  end
end
