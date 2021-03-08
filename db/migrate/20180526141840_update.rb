class Update < ActiveRecord::Migration[5.2]
  def change
    rename_column :courses, :creator_id, :teacher_id
    add_column :courses, :description, :text
  end
end
