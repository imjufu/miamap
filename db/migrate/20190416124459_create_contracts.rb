class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.references :producer, foreign_key: true, null: false

      t.timestamps
    end

    add_column :contracts, :deleted_at, :datetime
    add_index :contracts, :deleted_at
  end
end
