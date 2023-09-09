class TalentCourse < ApplicationRecord

  validates :course, presence: true
  validates :talent, presence: true

  belongs_to :course
  belongs_to :talent

  def complete_course
    # Check whether this is the last course in the learning path
    if course.order == course.learning_path.courses.length
      # Find the talent learning path so that we can close it.
      talent_learning_path = talent.talent_learning_paths.find { |tlp| tlp.learning_path.id == course.learning_path.id and tlp.talent.id == talent.id }
      talent_learning_path.update(completed: true)
    else
      # Assign next course in the learning path
      sorted_courses = course.learning_path.courses.sort_by{|h| h[:order]}
      next_course = sorted_courses[course.order]
      TalentCourse.create({course_id: next_course.id, talent_id: talent.id})
    end
  end
end
