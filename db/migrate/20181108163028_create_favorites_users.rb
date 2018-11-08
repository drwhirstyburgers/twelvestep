class CreateFavoritesUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites_users do |t|
      t.references :favorite, foreign_key: true
      t.references :student, foreign_key: true

      t.timestamps
    end
  end
end
