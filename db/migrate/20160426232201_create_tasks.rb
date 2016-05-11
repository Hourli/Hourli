class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.string :description
      t.boolean :completed, default: false
      t.float :duration
      t.references :job, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
