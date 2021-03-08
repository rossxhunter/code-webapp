class CreateLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :languages do |t|
      t.string :name
      t.string :ace_slug
      t.string :code_eval_slug

      t.timestamps
    end
  end
end
