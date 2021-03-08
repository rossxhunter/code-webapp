class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_teacher!, only: [:new, :create, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def assign_to_classes
    course = Course.find(params[:course_id])

    start_date = DateTime.new(
      params[:assignment]['date_start(1i)'].to_i,
      params[:assignment]['date_start(2i)'].to_i,
      params[:assignment]['date_start(3i)'].to_i,
      params[:assignment]['date_start(4i)'].to_i,
      params[:assignment]['date_start(5i)'].to_i
    )

    end_date = DateTime.new(
      params[:assignment]['date_due(1i)'].to_i,
      params[:assignment]['date_due(2i)'].to_i,
      params[:assignment]['date_due(3i)'].to_i,
      params[:assignment]['date_due(4i)'].to_i,
      params[:assignment]['date_due(5i)'].to_i
    )

    return redirect_to request.referrer unless params[:organisation_classes]

    org_class_ids = params[:organisation_classes][params[:course_id]].keys

    org_class_ids.each do |org_class_id|
      org_class = OrganisationClass.find(org_class_id)

      course.assign_to_students(
        org_class.students,
        current_teacher,
        start_date,
        end_date
      )
    end

    redirect_to request.referrer
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :creator_id)
    end
end
