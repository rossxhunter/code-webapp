class ChangeCodeLessonVisibleDefaultToTrue < ActiveRecord::Migration[5.2]
  def change
    change_column_default :code_lessons, :visible, true
  end
end
