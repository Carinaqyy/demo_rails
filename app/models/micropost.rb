class Micropost < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    validates :title, length: { maximum: 140 }, presence: true
    validates :content, length: { maximum: 140 }, presence: true
    validates :user_id, presence: true
end
