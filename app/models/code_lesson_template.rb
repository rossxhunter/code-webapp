class CodeLessonTemplate < ApplicationRecord
  belongs_to :track_template
  belongs_to :language

  validates :name,           presence: true, length: { maximum: 100 }
  validates :instructions,   presence: true
  validates :language_id,    presence: true
  validates :order,          presence: true
  validates :track_template, presence: true
end
