class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.references :user, null:false
      t.date :date, null:false
      t.float :time, null:false
      t.string :meal, null:false
      t.integer :num_of_calories, null:false
      t.timestamps null: false
    end
  end
end
