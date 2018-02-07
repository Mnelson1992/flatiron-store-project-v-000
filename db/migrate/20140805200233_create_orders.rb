class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :status
      t.integer :user_id
      t.integer :cart_id
      t.integer :total
    end 
  end
end
