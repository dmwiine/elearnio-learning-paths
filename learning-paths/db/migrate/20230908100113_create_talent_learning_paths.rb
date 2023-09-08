class CreateTalentLearningPaths < ActiveRecord::Migration[6.1]
  def change
    create_table :talent_learning_paths do |t|
      t.references :talent, null: false, foreign_key: true
      t.references :learning_path, null: false, foreign_key: true
      t.boolean :completed

      t.timestamps
    end
  end
end
