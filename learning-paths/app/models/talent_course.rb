class TalentCourse < ApplicationRecord
  belongs_to :course
  belongs_to :talent

  def complete_course
    # Check whether this is the last course in the learning path
    if course.order == course.learning_path.courses.length
      # Find the talent learning path so that we can close it.
      talent_learning_path = talent.talent_learning_paths.find { |tlp| tlp.learning_path == course.learning_path and tlp.talent == talent }
      talent_learning_path.update(completed: true)
    else
      # Assign next course in the learning path
      next_course = course.learning_path.courses[course.order]
      TalentCourse.create({course_id: next_course, talent_id: talent})
    end
  end
end
