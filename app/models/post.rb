class Post < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  # Like associations
  has_many :likes
  has_many :liked_by, through: :likes, source: :user

  validates :user_id,  presence: true
  validates :description, presence: true, length: { maximum: 1000 }

  def liked_by_user?(user)
    self.liked_by.include?(user)
  end
end
