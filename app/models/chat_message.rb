class ChatMessage < ApplicationRecord
  belongs_to :chat
  belongs_to :messageable, polymorphic: true
end
