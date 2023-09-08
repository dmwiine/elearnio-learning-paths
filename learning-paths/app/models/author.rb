class Author < ApplicationRecord
  validates :firstname, presence: true
  validates :lastname, presence: true
  has_many: courses

  def update_courses(author_id)
    courses.update_all(author_id: author_id)
  end
end
