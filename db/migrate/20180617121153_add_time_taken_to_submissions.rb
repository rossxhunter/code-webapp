class AddTimeTakenToSubmissions < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :time_taken, :integer
  end
end
