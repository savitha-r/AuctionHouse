class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :user_id
      t.integer :item_id
      t.integer :bid_position
      t.integer :bid_amount
      t.boolean :bid_status

      t.timestamps
    end
  end
end
