class AddHintFieldsToCodeLessons < ActiveRecord::Migration[5.2]
  def change
    add_column :code_lessons, :display_hint_after_attempts, :integer
    add_column :code_lessons, :display_hint_after_seconds, :integer
  end
end
