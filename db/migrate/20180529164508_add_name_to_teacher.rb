class AddNameToTeacher < ActiveRecord::Migration[5.2]
  def change
    add_column :teachers, :first_name, :string
    add_column :teachers, :last_name, :string
  end
end
