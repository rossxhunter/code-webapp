class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|
      t.integer :student_id
      t.integer :teacher_id
      t.integer :code_lesson_id
      t.datetime :date_due

      t.timestamps
    end
  end
end
