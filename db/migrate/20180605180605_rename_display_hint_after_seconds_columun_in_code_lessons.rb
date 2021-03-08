class RenameDisplayHintAfterSecondsColumunInCodeLessons < ActiveRecord::Migration[5.2]
  def change
    rename_column :code_lessons, :display_hint_after_seconds, :display_hint_after_minutes
  end
end
