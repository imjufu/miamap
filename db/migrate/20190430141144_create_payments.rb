class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.references :subscription, foreign_key: true
      t.monetize :amount, null: false
      t.string :means, null: false
      t.datetime :payed_at, null: false

      t.timestamps
    end
  end
end
