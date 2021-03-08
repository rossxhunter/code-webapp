class AddPointsToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :points, :integer
  end
end
