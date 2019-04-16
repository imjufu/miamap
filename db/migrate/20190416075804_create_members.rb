class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.date :date_of_birth, null: false
      t.string :email_address, null: false
      t.text :address, null: false
      t.string :postal_code, null: false
      t.string :city, null: false

      t.timestamps
    end

    add_column :members, :deleted_at, :datetime
    add_index :members, :deleted_at
  end
end
