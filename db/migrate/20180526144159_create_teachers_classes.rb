class CreateTeachersClasses < ActiveRecord::Migration[5.2]
  def change
    create_table :teachers_classes do |t|
      t.integer :teacher_id
      t.integer :organisation_class_id

      t.timestamps
    end
  end
end
