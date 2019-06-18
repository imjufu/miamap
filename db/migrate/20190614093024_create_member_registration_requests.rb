class CreateMemberRegistrationRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :member_registration_requests do |t|
      t.uuid :identifier
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :email
      t.text :address
      t.string :postal_code
      t.string :city
      t.integer :step
      t.datetime :received_at
      t.datetime :refused_at
      t.references :refused_by, index: true, foreign_key: { to_table: :users }
      t.datetime :accepted_at
      t.references :accepted_by, index: true, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :member_registration_requests, :identifier, unique: true
  end
end
