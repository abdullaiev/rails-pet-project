class User < ApplicationRecord
  has_many :posts

  before_save { self.email = email.downcase }

  validates :username,
            presence: true,
            uniqueness: true,
            length: { minimum: 3, maximum: 25 }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            presence: true,
            uniqueness: {case_sensitive: false},
            length: { minimum: 3, maximum: 255 },
            format: { with: EMAIL_REGEX }

  validates :bio, length: { maximum: 1000 }
end
