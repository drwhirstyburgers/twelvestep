class CreateSteppers < ActiveRecord::Migration[5.1]
  def change
    create_table :steppers do |t|
      t.belongs_to :user
      t.references :chat_room

      t.timestamps
    end
  end
end
