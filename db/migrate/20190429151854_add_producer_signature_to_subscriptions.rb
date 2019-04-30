class AddProducerSignatureToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :producer_signature, :binary
  end
end
