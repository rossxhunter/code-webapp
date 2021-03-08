class OrganisationClass < ApplicationRecord
  belongs_to :organisation

  has_many :classes_courses
  has_many :courses, class_name: 'Course', through: :classes_courses

  has_many :teachers_classes
  has_many :teachers, class_name: 'Teacher', through: :teachers_classes

  has_many :students_classes
  has_many :students, class_name: 'Student', through: :students_classes

  validates :name,         presence: true
  validates :organisation, presence: true

  def to_param
    [id, long_name.parameterize].join('-')
  end

  def long_name
    "#{code}: #{name}"
  end

  def outstanding_assignments(order = {date_due: :desc})
    common_assignments = []
    student_assignments = students.first.outstanding_assignments

    student_assignments.each do |assignment|
      students.each do |student|
        if student.outstanding_assignments.include?(assignment)
          common_assignments << assignment
        end
      end
    end
    return common_assignments
  end
  def outstanding_courses
    assignments = outstanding_assignments
    courses_from_assignments = []
    assignments.each do |a|
      code_lesson = a.code_lesson
      track = code_lesson.track
      course = track.course
      if !courses_from_assignments.include?(course) && courses.include?(course)
        courses_from_assignments << course
      end
    end
    return courses
  end
end
