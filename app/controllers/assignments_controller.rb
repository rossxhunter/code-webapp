class AssignmentsController < ApplicationController

  def old_assignments
    @student = Student.find(params[:id])
  end

  def cancel
    @assignment = Assignment.find(params[:id])
    @code_lesson = @assignment.code_lesson
    @teacher = @assignment.teacher
    @track = @code_lesson.track
    @course = @track.course

    @current_class.students.each do |student|
      @course.tracks.each do |track|
        track.code_lessons.each do |lesson|
          a = Assignment.where(teacher_id: @teacher.id, code_lesson_id: lesson.id, student_id: student.id).first
          if @current_class.students.include?(a.student)
            a.destroy()
            Submission.where("student_id= ? AND code_lesson_id= ? AND created_at > ?", student.id, lesson.id, a.date_start).destroy_all
          end
        end
      end
    end

  end

end
