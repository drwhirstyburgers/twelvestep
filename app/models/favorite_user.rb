class FavoriteUser < ApplicationRecord
  belongs_to :favorite
  belongs_to :student
end
