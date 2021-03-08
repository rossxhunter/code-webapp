class CreateChatMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_messages do |t|
      t.integer :chat_id
      t.text :message
      t.references :messageable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
