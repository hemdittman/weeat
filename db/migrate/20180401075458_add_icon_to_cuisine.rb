class AddIconToCuisine < ActiveRecord::Migration[5.1]
  def change
    add_column :cuisines, :icon, :string
  end
end
