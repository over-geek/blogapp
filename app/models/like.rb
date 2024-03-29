# Represents a like associated with a post and a user.
class Like < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  belongs_to :post

  after_save :update_likes_counter

  private

  def update_likes_counter
    post.update(likes_counters: post.likes.count)
  end
end
