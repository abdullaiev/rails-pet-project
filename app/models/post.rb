class Post < ApplicationRecord
  belongs_to :user
  validates :user_id,  presence: true
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image, presence: true
end
