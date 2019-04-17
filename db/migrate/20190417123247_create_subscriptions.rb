class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.references :member, foreign_key: true
      t.references :contract, foreign_key: true
      t.datetime :subscribed_at, null: false
      t.datetime :member_accepted_at
      t.datetime :farmer_accepted_at

      t.timestamps
    end

    add_column :subscriptions, :deleted_at, :datetime
    add_index :subscriptions, :deleted_at
  end
end
