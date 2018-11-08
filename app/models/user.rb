class User < ApplicationRecord
  attr_writer :login
  has_many :chat_room_users, dependent: :destroy
  has_many :chat_rooms, through: :chat_room_users, dependent: :destroy
  has_many :favorite_users, dependent: :destroy
  has_many :favorites, through: :favorite_users, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_one :catchphrases, dependent: :destroy
  has_one :years_sobers, dependent: :destroy
  has_one :bios, dependent: :destroy

  validates :bio, length: { maximum: 500 }, presence: true
  validates :catchphrase, length: { in: 5..90 }, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:login]

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_h).first
      end
  end
end
