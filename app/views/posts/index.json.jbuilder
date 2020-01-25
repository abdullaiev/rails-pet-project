# frozen_string_literal: true

json.array! @posts do |post|
  json.extract! post, :created_at, :updated_at, :description

  json.image_path url_for(post.image) if post.image.attached?

  json.like_count post.likes.count
  json.comment_count post.comments.count

  unless post.user.blank?
    json.author do
      json.extract! post.user, :id, :username, :full_name
    end
  end
end
