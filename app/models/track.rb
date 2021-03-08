class Track < ApplicationRecord
  belongs_to :course
  has_many :code_lessons, dependent: :destroy

  validates :name,   presence: true
  validates :order,  presence: true
  validates :course, presence: true

  def self.create_from_template(track_template, course)
    return Track.create(
      name: track_template.name,
      description: track_template.description,
      course_id: course.id,
      order: track_template.order
    )
  end

  def assign_to_students(students, teacher, date_start, date_due)
    code_lessons.each do |code_lesson|
      code_lesson.assign_to_students(students, teacher, date_start, date_due)
    end
  end

  def get_submissions_count
    submissions = 0

    code_lessons.each do |l|
      submissions += l.submissions.length
    end

    return submissions
  end

  def completion(student)
    num_completed = 0
    code_lessons.each do |l|
      num_completed += 1 if student.has_completed?(l)
    end
    puts "NUM COMPELTED  !!!!!!"
    return (num_completed.to_f / code_lessons.length)
  end

  def progress(student)
    return completion(student) * 100
  end
end
