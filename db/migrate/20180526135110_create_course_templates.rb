class CreateCourseTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :course_templates do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
