class AddStartingCodeToLiveCodingSessions < ActiveRecord::Migration[5.2]
  def change
    add_column :live_coding_sessions, :starting_code, :text, default: ""
  end
end
