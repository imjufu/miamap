class AddMemberSignatureToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :member_signature, :binary
  end
end
