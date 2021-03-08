class InsightsController < ApplicationController
  before_action :authenticate_teacher!

  def index
  end

  def course
    @course = Course.find(params[:id])
    @tracks = @course.tracks
  end

  def track
    @track = Track.find(params[:id])
    @code_lessons = @track.code_lessons
  end

  def code_lesson
    @code_lesson = CodeLesson.find(params[:id])
    # fetch students assigned this lesson?
  end

  def student
    @student = Student.find(params[:id])
  end

  def get_student_time_spent
    student = Student.find(params[:student_id])
    track = Track.find(params[:track_id])
    new_assignments = student.outstanding_assignments
    code_lessons_name = []
    time_spent_lessons = []
    new_assignments.each do |assignment|
      if assignment.code_lesson.track.id == track.id
        code_lesson = assignment.code_lesson
        code_lessons_name << code_lesson.name
        submissions = Submission.where(code_lesson_id: code_lesson.id, student_id: student.id)
        time_spent = 0
        submissions.each do |s|
          time_spent += s.time_taken
        end
        time_spent_lessons << time_spent
      end
    end
    return_obj = {
      code_lessons_name: code_lessons_name,
      time_spent_lessons: time_spent_lessons
    }
    render json: return_obj.to_json.inspect
  end

  def get_student_submissions
    student = Student.find(params[:student_id])
    track = Track.find(params[:track_id])
    new_assignments = student.outstanding_assignments
    num_completed = 0
    not_attempted = new_assignments.length
    code_lessons_name = []
    submission_counts = []
    new_assignments.each do |assignment|
      if assignment.code_lesson.track.id == track.id
        code_lesson = assignment.code_lesson
        code_lessons_name << code_lesson.name
        submissions = Submission.where(code_lesson_id: code_lesson.id, student_id: student.id)
        submission_counts << submissions.length
      end
    end
    return_obj = {
      code_lessons_name: code_lessons_name,
      submission_counts: submission_counts
    }
    render json: return_obj.to_json.inspect
  end

  def get_course_submissions
    course = Course.find(params[:course_id])
    tracks = course.tracks
    submission_counts = []
    avg_times = []
    tracks.each do |t|
      submission_counts << t.get_submissions_count
      total_time_for_track = 0.0

      @current_class.students.each do |s|
        total_time_for_student = 0.0
        t.code_lessons.each do |l|
          submissions = s.get_submissions(l).order({created_at: :desc})
          if submissions.size > 0
            total_time_for_student = total_time_for_student + submissions.first.time_taken
          end
        end
        total_time_for_track = total_time_for_track + total_time_for_student
      end

      avg_times << ((total_time_for_track / @current_class.students.size) / 60)
    end

    return_obj = {
      tracks: tracks,
      submission_counts: submission_counts,
      avg_times: avg_times
    }
    render json: return_obj.to_json.inspect
  end


  def get_track_submissions
    track = Track.find(params[:track_id])
    code_lessons = track.code_lessons
    submission_counts = []
    avg_times = []
    code_lessons.each do |l|
      submission_counts << l.submissions.length
      total_time = 0.0
      @current_class.students.each do |s|
        submissions = s.get_submissions(l).order({created_at: :desc})
        if submissions.size > 0
          total_time = total_time + submissions.first.time_taken
        end
      end

      avg_times << ((total_time / @current_class.students.size) / 60)
    end

    return_obj = {
      code_lessons: code_lessons,
      submission_counts: submission_counts,
      avg_times: avg_times
    }
    render json: return_obj.to_json.inspect
  end

  def get_code_lesson_submissions
    code_lesson = CodeLesson.find(params[:code_lesson_id])
    students_list = @current_class.students
    # submissions = code_lesson.submissions
    students = []
    # student_ids = []
    students_list.each do |s|
      submissions = s.get_submissions(code_lesson)
      submission_count = 0 + submissions.size
      time_taken = 0
      if submissions.size > 0
        time_taken = submissions.first.time_taken
      end
      student = s.attributes
      student.merge!({
        submissions_count: submission_count,
        name: s.name,
        time_taken: time_taken
      })
      students << student
    end
    return_obj = {
      students: students
    }
    render json: return_obj.to_json.inspect
  end


end
