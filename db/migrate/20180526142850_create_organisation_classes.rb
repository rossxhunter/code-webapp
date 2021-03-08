class CreateOrganisationClasses < ActiveRecord::Migration[5.2]
  def change
    create_table :organisation_classes do |t|
      t.string :name
      t.string :code
      t.integer :organisation_id

      t.timestamps
    end
  end
end
