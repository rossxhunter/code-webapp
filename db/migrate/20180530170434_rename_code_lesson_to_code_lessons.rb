class RenameCodeLessonToCodeLessons < ActiveRecord::Migration[5.2]
  def change
    rename_table :code_lesson, :code_lessons
  end
end
