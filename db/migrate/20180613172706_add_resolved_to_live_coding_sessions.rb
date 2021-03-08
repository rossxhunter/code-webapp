class AddResolvedToLiveCodingSessions < ActiveRecord::Migration[5.2]
  def change
    add_column :live_coding_sessions, :resolved, :boolean, default: false
  end
end
