class AddSuccessToSubmissions < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :success, :boolean, default: false
  end
end
