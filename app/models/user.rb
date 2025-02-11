class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :name, presence: true

  has_one_attached :avatar
  has_many :rooms
  has_many :reservations
end
