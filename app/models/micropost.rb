class Micropost < ApplicationRecord
    belongs_to :user
    has_many :comments
    validates :title, length: { maximum: 140 }, presence: true
    validates :content, length: { maximum: 140 }, presence: true
end
