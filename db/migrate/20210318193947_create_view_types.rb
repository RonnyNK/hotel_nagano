class CreateViewTypes < ActiveRecord::Migration
  def change
    create_table :view_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
