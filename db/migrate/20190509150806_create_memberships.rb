class CreateMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :memberships do |t|
      t.references :membership_form, foreign_key: true, null: false
      t.references :member, foreign_key: true, null: false
      t.datetime :membershiped_at, null: false
      t.datetime :member_accepted_at

      t.timestamps
    end

    add_column :memberships, :deleted_at, :datetime
    add_index :memberships, :deleted_at
  end
end
