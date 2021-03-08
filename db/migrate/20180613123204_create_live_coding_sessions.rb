class CreateLiveCodingSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :live_coding_sessions do |t|
      t.integer :student_id
      t.integer :teacher_id

      t.timestamps
    end
  end
end
