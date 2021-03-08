class CreateCodeLessonTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :code_lesson_templates do |t|
      t.string :name
      t.text :instruction
      t.text :hint
      t.text :starting_code
      t.integer :language_id
      t.integer :order
      t.integer :track_template_id
      t.text :correctness_test

      t.timestamps
    end
  end
end
