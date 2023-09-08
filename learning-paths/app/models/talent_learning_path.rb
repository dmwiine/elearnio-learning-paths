class TalentLearningPath < ApplicationRecord
  validates :talent, presence: true
  validates :learning_path, presence: true

  belongs_to :talent
  belongs_to :learning_path
end
