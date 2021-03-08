class RenameCodeLessonTemplateInstructionToInstructions < ActiveRecord::Migration[5.2]
  def change
    rename_column :code_lesson_templates, :instruction, :instructions
  end
end
