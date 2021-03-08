class ChangeDefaultValueOfCorrectnessTest < ActiveRecord::Migration[5.2]
  def change
    change_column :code_lessons, :correctness_test, :text, default: ""
  end
end
