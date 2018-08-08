class AddYearsSoberToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :years_sober, :string
    add_index :users, :years_sober
  end
end
