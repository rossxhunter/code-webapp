class Submission < ApplicationRecord
  belongs_to :code_lesson
  belongs_to :student

  validates :code_lesson, presence: true
  validates :code,        presence: true
  validates :student_id,  presence: true

  def is_successful
    return success
  end
end
