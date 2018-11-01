class ChatRoom < ApplicationRecord
  has_and_belongs_to_many :users
  has_one :usernames, dependent: :destroy
  has_many :messages, dependent: :destroy
end
