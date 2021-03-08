class CourseTemplatesController < ApplicationController
  before_action :set_course_template, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_teacher!

  # GET /course_templates
  # GET /course_templates.json
  def index
    @course_templates = CourseTemplate.all
    @organisation_classes = current_teacher.organisation.organisation_classes
  end

  # GET /course_templates/1
  # GET /course_templates/1.json
  def show
  end

  # GET /course_templates/new
  def new
    @course_template = CourseTemplate.new
  end

  # GET /course_templates/1/edit
  def edit
  end

  # POST /course_templates
  # POST /course_templates.json
  def create
    @course_template = CourseTemplate.new(course_template_params)

    respond_to do |format|
      if @course_template.save
        format.html { redirect_to @course_template, notice: 'Course template was successfully created.' }
        format.json { render :show, status: :created, location: @course_template }
      else
        format.html { render :new }
        format.json { render json: @course_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_templates/1
  # PATCH/PUT /course_templates/1.json
  def update
    respond_to do |format|
      if @course_template.update(course_template_params)
        format.html { redirect_to @course_template, notice: 'Course template was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_template }
      else
        format.html { render :edit }
        format.json { render json: @course_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_templates/1
  # DELETE /course_templates/1.json
  def destroy
    @course_template.destroy
    respond_to do |format|
      format.html { redirect_to course_templates_url, notice: 'Course template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_to_organisation
    course_template = CourseTemplate.find(params[:course_template_id])
    organisation = current_teacher.organisation

    org_class_ids = params[:organisation_classes][params[:course_template_id]].keys

    org_class_ids.each do |org_class_id|
      org_class = OrganisationClass.find(org_class_id)
      course = organisation.add_course_template(course_template, org_class, current_teacher)
    end

    redirect_to teacher_dashboard_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_template
      @course_template = CourseTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_template_params
      params.require(:course_template).permit(:name, :description)
    end
end
