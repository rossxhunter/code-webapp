class AddStudentIdToSubmissions < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :student_id, :integer
  end
end
