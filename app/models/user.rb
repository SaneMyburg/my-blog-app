class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_save :generate_api_token

  def recent_posts(limit = 3)
    posts.order(created_at: :asc).limit(limit)
  end

  def admin?
    role == 'admin'
  end

  private

  def generate_api_token
    self.api_token = SecureRandom.hex(16)
  end
end
