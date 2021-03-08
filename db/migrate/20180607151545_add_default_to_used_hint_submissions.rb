class AddDefaultToUsedHintSubmissions < ActiveRecord::Migration[5.2]
  def change
    change_column :submissions, :used_hint, :boolean, default: false
  end
end
