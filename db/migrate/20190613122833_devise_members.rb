class DeviseMembers < ActiveRecord::Migration[5.2]
  def change
    ## Database authenticatable
    rename_column :members, :email_address, :email
    change_column :members, :email, :string, null: false, default: ''
    add_column :members, :encrypted_password, :string, null: false, default: ''

    ## Recoverable
    add_column :members, :reset_password_token, :string
    add_column :members, :reset_password_sent_at, :datetime

    ## Rememberable
    add_column :members, :remember_created_at, :datetime

    ## Trackable
    add_column :members, :sign_in_count, :integer, default: 0, null: false
    add_column :members, :current_sign_in_at, :datetime
    add_column :members, :last_sign_in_at, :datetime
    add_column :members, :current_sign_in_ip, :inet
    add_column :members, :last_sign_in_ip, :inet

    ## Confirmable
    add_column :members, :confirmation_token, :string
    add_column :members, :confirmed_at, :datetime
    add_column :members, :confirmation_sent_at, :datetime
    add_column :members, :unconfirmed_email, :string  # Only if using reconfirmable

    ## Lockable
    add_column :members, :failed_attempts, :integer, default: 0, null: false # Only if lock strategy is :failed_attempts
    add_column :members, :unlock_token, :string # Only if unlock strategy is :email or :both
    add_column :members, :locked_at, :datetime

    add_index :members, :email, unique: true
    add_index :members, :reset_password_token, unique: true
    add_index :members, :confirmation_token, unique: true
    add_index :members, :unlock_token, unique: true
  end
end
