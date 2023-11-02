class Comment < ApplicationRecord
  belongs_to :micropost
  validates :commenter, presence: true
  validates :body, length: { maximum: 140 }, presence: true

end
