class CreateStudentsClasses < ActiveRecord::Migration[5.2]
  def change
    create_table :students_classes do |t|
      t.integer :student_id
      t.integer :organisation_class_id

      t.timestamps
    end
  end
end
