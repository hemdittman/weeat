class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :reviewer_name
      t.integer :rating
      t.text :comment
      t.belongs_to :restaurant, foreign_key: true, null: false

      t.timestamps
    end
    add_index :reviews, [:restaurant_id, :rating]
  end
end
