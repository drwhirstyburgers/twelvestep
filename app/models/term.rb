class Term < ApplicationRecord
  belongs_to :user

  validates :agree, presence: true
end
