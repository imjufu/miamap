class CreateProducers < ActiveRecord::Migration[5.2]
  def change
    create_table :producers do |t|
      t.string :name, null: false
      t.string :email_address, null: false
      t.text :address, null: false
      t.string :postal_code, null: false
      t.string :city, null: false

      t.timestamps
    end

    add_column :producers, :deleted_at, :datetime
    add_index :producers, :deleted_at
  end
end
