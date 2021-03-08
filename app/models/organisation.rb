class Organisation < ApplicationRecord
  has_many :organisation_classes
  has_many :teachers
  has_many :students

  validates :name, presence: true

  def add_course_template(course_template, org_class, teacher)
    course = Course.create_from_template(course_template, self, teacher)
    org_class.courses << course

    course_template.track_templates.each do |track_template|
      track = Track.create_from_template(track_template, course)

      track_template.code_lesson_templates.each do |code_lesson_template|
        code_lesson = CodeLesson.create_from_template(code_lesson_template, track)
      end
    end

    return course
  end
end
