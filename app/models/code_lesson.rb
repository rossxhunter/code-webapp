class CodeLesson < ApplicationRecord
  include CodeLessonsHelper

  belongs_to :track
  belongs_to :language
  has_many :submissions, dependent: :destroy
  has_many :assignments

  validates :name,         presence: true, length: { maximum: 100 }
  validates :language,     presence: true
  validates :instructions, presence: true, on: :update
  validates :track,        presence: true, on: :update
  validates :visible,      presence: true, on: :update

  def to_param
    [id, name.parameterize].join('-')
  end

  def submissions_for(student)
    submissions.where(student_id: student.id)
  end

  def submission_count_for(student)
    submissions_for(student).count
  end

  def most_recent_submission_for(student)
    sorted_submissions = submissions_for(student).order(created_at: :desc)

    return nil if sorted_submissions.empty?

    sorted_submissions.first
  end

  def get_assignment_for(student)
    Assignment.find_by(student_id: student.id, code_lesson_id: id)
  end

  def display_hint?(student)
    !display_hint_after_attempts.nil? && submission_count_for(student) >= display_hint_after_attempts
  end

  def self.create_from_template(lesson_template, track)
    return CodeLesson.create(
      name: lesson_template.name,
      instructions: lesson_template.instructions,
      starting_code: lesson_template.starting_code,
      correctness_test: lesson_template.correctness_test,
      language_id: lesson_template.language_id,
      order: lesson_template.order,
      track_id: track.id,
      visible: true
    )
  end

  def assign_to_students(students, teacher, date_start, date_due)
    students.each do |student|
      Assignment.create(
        student_id: student.id,
        teacher_id: teacher.id,
        code_lesson_id: self.id,
        date_start: date_start,
        date_due: date_due
      )
    end
  end

  def check_correctness(user_code, output)
    output_array = format_code_output(output)
    ccode = correctness_code(language, correctness_test, output_array)
    code_to_evaluate = user_code + "\n" + ccode
    result = evaluate_code(code_to_evaluate, language)
    output_strs = format_code_output(result['output'])
    return output_strs[output_strs.length - 1] == "true"
  end
end
