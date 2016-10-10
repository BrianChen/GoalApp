class CreateGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :goals do |t|
      t.string :title ,null: false
      t.boolean :visible ,null: false
      t.integer :user_id ,null: false

      t.timestamps
    end
    add_index :goals, :user_id
  end
end