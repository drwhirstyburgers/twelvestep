class CreateTerms < ActiveRecord::Migration[5.1]
  def change
    create_table :terms do |t|
      t.text :body
      t.boolean :agree
      t.belongs_to :user

      t.timestamps
    end
  end
end
