class CreateSubmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :submissions do |t|
      t.integer :code_lesson_id
      t.text :code

      t.timestamps
    end
  end
end
