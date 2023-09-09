class CreateTalentCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :talent_courses do |t|
      t.references :course, null: false, foreign_key: true
      t.references :talent, null: false, foreign_key: true
      t.boolean :completed, defaults: false

      t.timestamps
    end
  end
end
