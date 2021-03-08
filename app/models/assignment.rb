class Assignment < ApplicationRecord
  belongs_to :student
  belongs_to :teacher
  belongs_to :code_lesson

  def track
    code_lesson.track
  end

  def course
    track.course
  end
end
