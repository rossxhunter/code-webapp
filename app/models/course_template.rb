class CourseTemplate < ApplicationRecord
  has_many :track_templates, dependent: :destroy

  validates :name,        presence: true
  validates :description, presence: true
end
