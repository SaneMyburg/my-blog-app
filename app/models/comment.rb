class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  validates :text, presence: true

  after_create :update_post_comments_counter
  after_destroy :update_post_comments_counter

  private

  def update_post_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
