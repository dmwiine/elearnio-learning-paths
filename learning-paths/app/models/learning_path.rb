class LearningPath < ApplicationRecord
    validates :name, presence: true
    
    has_many: courses, order: 'courses.order' 
    has_many: talent_learning_paths
    has_many: talents, through: talent_learning_paths
end
