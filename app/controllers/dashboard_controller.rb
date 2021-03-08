class DashboardController < ApplicationController
  before_action :authenticate_teacher!, only: :teacher
  before_action :authenticate_student!, only: :student

  def teacher
    @code_lesson = CodeLesson.new
    @chats = Chat.find_all_for_teacher(current_teacher)
  end

  def student
    @submissions = Submission.where(student_id: current_student.id)

    if @submissions.any?
      @sorted = @submissions.order(created_at: :desc)
      @latest = @sorted.first
      @current_code_lesson = @latest.code_lesson
      @current_track = @current_code_lesson.track
      @current_course = @current_track.course
    end

    @assignments = Assignment.where(student_id: current_student.id)
  end

  def change_class
    cookies.permanent[:class_id] = params[:id]
    cookies[:course_id] = nil
    cookies[:track_id] = nil
    cookies[:code_lesson_id] = nil

    if student_signed_in?
      org_class = OrganisationClass.find(cookies[:class_id])
      return redirect_to organisation_class_courses_path(org_class)
    end

    redirect_to teacher_dashboard_path
  end

  def get_tracks
    course = Course.find(params[:course_id])
    cookies[:course_id] = params[:course_id]
    cookies[:track_id] = nil
    cookies[:code_lesson_id] = nil
    return_obj = {
      tracks: course.tracks,
      display_tracks_link: course_tracks_path(course)
    }
    render json: return_obj.to_json.inspect
  end

  def get_code_lessons
    track = Track.find(params[:track_id])
    cookies[:track_id] = params[:track_id]
    cookies[:code_lesson_id] = nil
    return_obj = {
      code_lessons: track.code_lessons.order(:order),
      display_lessons_link: track_code_lessons_path(track),
    }
    render json: return_obj.to_json.inspect
  end

  def get_students
    code_lesson = CodeLesson.find(params[:code_lesson_id])
    org_class = OrganisationClass.find(cookies[:class_id])
    cookies[:code_lesson_id] = params[:code_lesson_id]

    students = org_class.students
    results = []
    num_of_subs = []
    hint_used = []
    students.each do |s|
      all_submissions = s.get_submissions(code_lesson)
      if all_submissions.length == 0
        results << nil
        num_of_subs << 0
        hint_used << false
      else
        result = false
        used_hint = false
        all_submissions.each do |submission|
          result = result || submission.success
          used_hint = used_hint || submission.used_hint
        end
        results << result
        num_of_subs << all_submissions.size
        hint_used << used_hint
      end
    end
    return_obj = {
      students: students,
      results: results,
      num_of_subs: num_of_subs,
      hint_used: hint_used
    }
    render json: return_obj.to_json.inspect
  end
end
