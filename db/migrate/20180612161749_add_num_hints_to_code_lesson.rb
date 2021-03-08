class AddNumHintsToCodeLesson < ActiveRecord::Migration[5.2]
  def change
    add_column :code_lessons, :num_hints, :integer
  end
end
