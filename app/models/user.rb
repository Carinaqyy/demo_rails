class User < ApplicationRecord
    has_many :microposts, dependent: :destroy
    has_many :comments, dependent: :destroy

    EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :name, presence: true
    validates :email, presence: true, format: { with: EMAIL_FORMAT }, uniqueness: true
end
