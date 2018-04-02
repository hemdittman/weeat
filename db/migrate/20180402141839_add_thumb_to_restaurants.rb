class AddThumbToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :thumb_url, :string
  end
end
