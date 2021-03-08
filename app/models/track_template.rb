class TrackTemplate < ApplicationRecord
  belongs_to :course_template
  has_many :code_lesson_templates, dependent: :destroy

  validates :name,            presence: true
  validates :order,           presence: true
  validates :course_template, presence: true
end
