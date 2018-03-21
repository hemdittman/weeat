class CreateRestaurants < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.integer :cuisine_id, null: false
      t.integer :rating
      t.boolean :accepts_10bis, default: false
      t.string :address, null: false
      t.integer :max_delivery_time_minutes, default: 90

      t.timestamps
    end
    add_index :restaurants, :name
    add_index :restaurants, :cuisine_id
    add_index :restaurants, :accepts_10bis
    add_index :restaurants, [:name, :address], unique: true
  end
end
