class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User'

  after_create :increment_comments_counter
  after_destroy :decrement_comments_counter

  def increment_comments_counter
    post.increment!(:comments_counter)
  end
  
  def decrement_comments_counter
    post.decrement!(:comments_counter)
  end
end