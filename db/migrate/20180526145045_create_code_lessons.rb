class CreateCodeLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :code_lesson do |t|
      t.string :name
      t.text :instruction
      t.text :hint
      t.text :starting_code
      t.integer :language_id
      t.integer :order
      t.integer :track_id
      t.text :correctness_test
      t.datetime :date_due
      t.datetime :date_start
      t.boolean :visible

      t.timestamps
    end
  end
end
