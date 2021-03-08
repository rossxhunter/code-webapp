class Language < ApplicationRecord
  validates :name,              presence: true
  validates :ace_slug,          presence: true
  validates :code_eval_slug,    presence: true
  validates :code_eval_version, presence: true
end
