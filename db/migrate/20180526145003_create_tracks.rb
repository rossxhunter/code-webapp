class CreateTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :tracks do |t|
      t.string :name
      t.text :description
      t.integer :course_id
      t.integer :order

      t.timestamps
    end
  end
end
