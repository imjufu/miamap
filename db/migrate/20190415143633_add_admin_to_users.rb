class AddAdminToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :profile, :string, null: false, default: Profile::LEVEL_0
  end
end
