class CreateFarmers < ActiveRecord::Migration[5.2]
  def change
    create_table :farmers do |t|
      t.string :name, null: false
      t.string :email_address, null: false
      t.text :address, null: false
      t.string :postal_code, null: false
      t.string :city, null: false

      t.timestamps
    end

    add_column :farmers, :deleted_at, :datetime
    add_index :farmers, :deleted_at
  end
end
