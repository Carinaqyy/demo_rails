class Comment < ApplicationRecord
  belongs_to :micropost
  validates :content, length: { maximum: 140 }, presence: true

end
