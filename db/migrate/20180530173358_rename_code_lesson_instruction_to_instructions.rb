class RenameCodeLessonInstructionToInstructions < ActiveRecord::Migration[5.2]
  def change
    rename_column :code_lessons, :instruction, :instructions
  end
end
