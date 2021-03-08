class AddDefaultToPoints < ActiveRecord::Migration[5.2]
  def change
    change_column :students, :points, :integer, default: 0
  end
end
