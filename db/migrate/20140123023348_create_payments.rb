class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.integer :amount
      t.integer :credit_points
      t.string :transaction_ref

      t.timestamps
    end
  end
end
