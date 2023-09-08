class CreateTalents < ActiveRecord::Migration[6.1]
  def change
    create_table :talents do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.references :author, null: true, foreign_key: true

      t.timestamps
    end
  end
end
