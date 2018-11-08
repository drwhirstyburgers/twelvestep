class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true
      t.references :favorited_user, index: true

      t.timestamps
    end

    add_foreign_key :favorites, :users, column: :favorited_user_id
    add_index :favorites, [:user_id, :favorited_user_id], unique: true
  end
end
