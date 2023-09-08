class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.string :description
      t.references :author, null: false, foreign_key: true
      t.references :learning_path, null: false, foreign_key: true
      t.integer :order, null: false, defaults: 1

      t.timestamps
    end
  end
end
