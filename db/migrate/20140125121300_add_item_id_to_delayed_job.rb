class AddItemIdToDelayedJob < ActiveRecord::Migration
  def change
  	add_column :delayed_jobs, :item_id, :integer
  end
end
