class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates_presence_of :body
  scope :ordenados, lambda{ order("created_at DESC") }

end
