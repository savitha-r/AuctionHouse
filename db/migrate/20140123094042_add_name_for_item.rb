class AddNameForItem < ActiveRecord::Migration
  def change
  	add_column :items, :name, :string
  end
end
