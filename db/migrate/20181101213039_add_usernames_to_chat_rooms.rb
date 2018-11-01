class AddUsernamesToChatRooms < ActiveRecord::Migration[5.1]
  def change
    add_column :chat_rooms, :username, :string
    add_index :chat_rooms, :username
  end
end
