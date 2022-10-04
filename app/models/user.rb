class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id'
  def three_most_recent_records
    posts.order(created_at: :desc).first(3)
  end
end
