class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null:false
      t.string :encrypted_password, null:false
      t.integer :num_of_calories, null:false, default:0
      t.string :role, null:false
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
