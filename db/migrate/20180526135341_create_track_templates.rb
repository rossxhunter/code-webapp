class CreateTrackTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :track_templates do |t|
      t.string :name
      t.integer :order
      t.integer :course_template_id
      t.text :description

      t.timestamps
    end
  end
end
