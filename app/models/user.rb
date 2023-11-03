class User < ApplicationRecord
    has_many :microposts
    has_many :comments
    
    EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :name, presence: true
    validates :email, presence: true, format: { with: EMAIL_FORMAT }, uniqueness: true
end
