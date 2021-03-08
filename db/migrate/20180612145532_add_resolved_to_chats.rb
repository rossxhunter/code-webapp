class AddResolvedToChats < ActiveRecord::Migration[5.2]
  def change
    add_column :chats, :resolved, :boolean, default: false
  end
end
