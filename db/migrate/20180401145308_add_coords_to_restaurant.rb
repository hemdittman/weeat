class AddCoordsToRestaurant < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :longitude, :float
    add_column :restaurants, :latitude, :float
  end
end
