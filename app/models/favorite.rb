class Favorite < ApplicationRecord
  has_many :favorite_users, dependent: :destroy
  has_many :users, through: :favorite_users
end
