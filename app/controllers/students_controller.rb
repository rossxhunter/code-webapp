class StudentsController < ApplicationController
  before_action :authenticate_teacher!, only: :index

  def index
  end

  def get_assignments
    student = Student.find(params[:id])
    assignments = student.outstanding_assignments({ created_at: :asc })
    return_obj = {
      assignments: assignments,
      notification_message: "You have a new assignment, go to your student dashboard to view it!"
    }
    render json: return_obj.to_json
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      params[:student][:organisation_classes].each do |c|
        if c
          StudentsClass.create(student_id: @student.id, organisation_class_id: c)
        end
      end
      return redirect_to(students_path)
    else
      render :new

    end
  end

  def show
    @student = Student.find(params[:id])
  end

  def edit
    @student = Student.find(params[:id])
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    redirect_to(students_path)
  end

  def update
    @student = Student.find(params[:id])

    if @student.update(student_params)
      if student_signed_in?
        return redirect_to(student_dashboard_path)
      end
      return redirect_to(student_path)
    end
  end



  private
  def student_params
    params.require(:student).permit(:first_name, :last_name, :password, :password_confirmation, :organisation_id, :email)
  end
end
