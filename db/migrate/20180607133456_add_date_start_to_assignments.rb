class AddDateStartToAssignments < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :date_start, :datetime
  end
end
