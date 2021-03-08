class AddOrganisationIdToStudentsAndTeachers < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :organisation_id, :integer
    add_column :teachers, :organisation_id, :integer
  end
end
