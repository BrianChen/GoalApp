class Goal < ApplicationRecord
  validates :title, :visible, :user_id, presence: true
  
  belongs_to :user
  has_many :comments
end
