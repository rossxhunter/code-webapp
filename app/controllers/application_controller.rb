class ApplicationController < ActionController::Base
  before_action :set_class_cookie
  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :layout_by_resource

  include CodeLessonsHelper

  def layout_by_resource
    if (controller_name == 'code_lessons' && (action_name == 'show' || action_name == 'edit' || action_name == 'update' || action_name == 'chat')) || (controller_name == 'live_coding_sessions' && action_name == 'show') || (controller_name == 'submissions' && action_name == 'show')
      return 'code_lesson'
    end

    if controller_name == 'pages' && action_name == 'home'
      return 'application_no_cont'
    end

    return 'application'
  end

  def set_class_cookie
    if teacher_signed_in? && !cookies.permanent[:class_id]
      cookies.permanent[:class_id] = current_teacher.organisation.organisation_classes.first.id
    end

    @current_class = cookies[:class_id].blank? ? nil : OrganisationClass.find(cookies.permanent[:class_id])
    @current_course = cookies[:course_id].blank? ? nil : Course.find(cookies[:course_id])
    @current_track = cookies[:track_id].blank? ? nil : Track.find(cookies[:track_id])
    @current_code_lesson = cookies[:code_lesson_id].blank? ? nil : CodeLesson.find(cookies[:code_lesson_id])
  end

  def after_sign_in_path_for(resource)
    if resource.instance_of? Student
      return student_dashboard_path
    end

    if resource.instance_of? Teacher
      return teacher_dashboard_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :organisation_id, :first_name, :last_name) }
  end
end
