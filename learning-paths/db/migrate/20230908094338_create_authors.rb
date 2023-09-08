class CreateAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :authors do |t|
      t.string :firstname, null: false 
      t.string :lastname, null: false
      t.string :bio

      t.timestamps
    end
  end
end
