class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.string :token
      t.integer :starter_id
      t.integer :receiver_id

      t.timestamps
    end
    add_index :conversations, :token, unique: true
    add_foreign_key :conversations, :users, column: :starter_id
    add_foreign_key :conversations, :users, column: :receiver_id
  end
end
