class SubmissionsController < ApplicationController

  def student_submissions
    @code_lesson = CodeLesson.find(params[:code_lesson_id])
    @student = Student.find(params[:student_id])
    @submissions = Submission.where(student_id: @student.id, code_lesson_id: @code_lesson.id)
  end

  def show
    @submission = Submission.find(params[:id])
    @code_lesson = @submission.code_lesson
    @submissions = @code_lesson.submissions
  end
end
