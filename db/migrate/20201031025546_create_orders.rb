class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|

      t.integer :customer_id
      t.string :shipping_cost
      t.integer :pay_money
      t.integer :pay_way, default: 0
      t.string :name
      t.string :postcode
      t.string :address
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
