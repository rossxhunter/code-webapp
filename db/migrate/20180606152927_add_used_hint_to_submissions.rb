class AddUsedHintToSubmissions < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :used_hint, :boolean
  end
end
