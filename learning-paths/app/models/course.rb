class Course < ApplicationRecord
  validates :name, presence: true
  validates :order, presence: true

  belongs_to :author
  belongs_to :learning_path
  has_many :talent_courses
  has_many :talents, through: :talent_courses
end
