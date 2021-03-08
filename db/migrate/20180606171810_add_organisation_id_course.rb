class AddOrganisationIdCourse < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :organisation_id, :integer
  end
end
