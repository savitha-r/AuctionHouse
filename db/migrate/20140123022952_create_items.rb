class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :description
      t.integer :price
      t.datetime :starting_time
      t.datetime :ending_time
      t.integer :starting_bid
      t.integer :bid_unit

      t.timestamps
    end
  end
end
