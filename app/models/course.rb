class Course < ApplicationRecord
  has_many :classes_courses
  has_many :organisation_classes, class_name: 'OrganisationClass', through: :classes_courses
  has_many :tracks, dependent: :destroy

  validates :name, presence: true

  def self.create_from_template(course_template, organisation, teacher)
    return Course.create(
      name: course_template.name,
      description: course_template.description,
      teacher_id: teacher.id,
      organisation_id: organisation.id
    )
  end

  def assign_to_students(students, teacher, date_start, date_due)
    tracks.each do |track|
      track.assign_to_students(students, teacher, date_start, date_due)
    end
  end

  def completion(student)
    total_completion = 0

    tracks.each do |t|
      total_completion = total_completion + t.completion(student)
    end

    return total_completion / tracks.length
  end

  def progress(student)
    (completion(student) * 100).ceil
  end

  def teachers
    teachers = []

    organisation_classes.each do |org_class|
      teachers = [teachers, org_class.teachers].flatten
    end

    teachers
  end
end
