class AddPinToConversations < ActiveRecord::Migration[5.0]
  def change
    add_column :conversations, :pin, :string, limit: 5
  end
end
