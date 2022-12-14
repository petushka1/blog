class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User'

  after_create :increment_posts_counter
  after_destroy :decrement_posts_counter

  validates :title, presence: true, length: { in: 1..250 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def increment_posts_counter
    author.increment!(:posts_counter)
  end

  def decrement_posts_counter
    author.decrement!(:posts_counter)
  end

  def five_recent_comments
    comments.order(created_at: :desc).first(5)
  end
end
