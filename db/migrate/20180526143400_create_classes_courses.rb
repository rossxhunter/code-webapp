class CreateClassesCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :classes_courses do |t|
      t.integer :organisation_class_id
      t.integer :course_id

      t.timestamps
    end
  end
end
