class AddCodeLessonIdToLiveCodingSessions < ActiveRecord::Migration[5.2]
  def change
    add_column :live_coding_sessions, :code_lesson_id, :integer
  end
end
