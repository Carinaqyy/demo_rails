class Micropost < ApplicationRecord
    belongs_to :user
    has_many :comments
    validates :content, length: { maximum: 140 }, presence: true
end
