class User < ApplicationRecord
  # This line is missing!
  has_many :listings, dependent: :destroy
  
  validates :username, presence: true
  validates :email, presence: true
end