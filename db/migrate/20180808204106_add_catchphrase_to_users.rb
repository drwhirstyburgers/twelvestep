class AddCatchphraseToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :catchphrase, :string
    add_index :users, :catchphrase
  end
end
