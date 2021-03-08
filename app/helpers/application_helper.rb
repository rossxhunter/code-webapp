module ApplicationHelper

  def current_user_type
    return 'Teacher' if teacher_signed_in?
    return 'Student' if student_signed_in?
    return ''
  end
end
