class Talent < ApplicationRecord
  validates :username, presence: true
  validates :email, presence: true

  belongs_to :author
  has_many :talent_learning_paths
  has_many :talent_courses

  has_many :courses, through: :talent_courses
  has_many :learning_paths, through: :talent_learning_paths
end
