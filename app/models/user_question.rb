class UserQuestion < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :user_questions
  has_many :answers
end
