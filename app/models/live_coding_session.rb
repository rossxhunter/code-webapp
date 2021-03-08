class LiveCodingSession < ApplicationRecord
  belongs_to :teacher
  belongs_to :student
  belongs_to :code_lesson
end
