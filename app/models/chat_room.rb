class ChatRoom < ApplicationRecord
  belongs_to :users
  has_many :steppers
  has_many :chats_with_steppers, through: :steppers, source: :user
  has_many :messages, dependent: :destroy
end
