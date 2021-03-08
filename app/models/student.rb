class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :students_classes
  has_many :organisation_classes, class_name: 'OrganisationClass', through: :students_classes
  has_many :assignments
  has_many :chat_messages, as: :messagable
  belongs_to :organisation

  validates :first_name,   presence: true
  validates :last_name,    presence: true
  validates :organisation, presence: true

  def name
    "#{first_name} #{last_name}"
  end

  def get_tracks_assignments
    assignments = outstanding_assignments({ created_at: :asc })
    tracks = []
    assignments.each do |a|
      track = a.code_lesson.track
      if !tracks.include?(track)
        tracks << track
      end
    end
    return tracks
  end

  def outstanding_assignments(order = { date_due: :asc })
    @assignments = Assignment.where(
      "student_id = ? AND date_start < ? AND date_due > ?",
      id, Time.now, Time.now
    ).order(order)

    # @assignments.select do |assignment|
    #   !has_completed?(assignment.code_lesson)
    # end
    return @assignments
  end

  def old_assignments(order = {date_due: :desc})
    @assignments = Assignment.where("student_id = ? AND date_due < ?", id, Time.now).order(order)
  end

  def old_courses()
    @old_assignments = old_assignments
    @old_courses = []
    @assignments.each do |a|
      code_lesson = a.code_lesson
      track = code_lesson.track
      course = track.course
      if !@old_courses.include?(course)
        @old_courses << course
      end
    end
    return @old_courses
  end

  def outstanding_courses()
    @assignments = outstanding_assignments
    @courses = []
    @assignments.each do |a|
      code_lesson = a.code_lesson
      track = code_lesson.track
      course = track.course
      if !@courses.include?(course)
        @courses << course
      end
    end
    return @courses
  end


  def has_completed?(code_lesson)
    Submission.where(student_id: id, code_lesson_id: code_lesson.id, success: true).any?
  end

  def get_submissions(code_lesson)
    Submission.where(student_id: id, code_lesson_id: code_lesson.id)
  end
end
