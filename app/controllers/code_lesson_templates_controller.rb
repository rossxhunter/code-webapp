class CodeLessonTemplatesController < ApplicationController
  before_action :set_code_lesson_template, only: [:show, :edit, :update, :destroy]

  # GET /code_lesson_templates
  # GET /code_lesson_templates.json
  def index
    @code_lesson_templates = CodeLessonTemplate.all
  end

  # GET /code_lesson_templates/1
  # GET /code_lesson_templates/1.json
  def show
  end

  # GET /code_lesson_templates/new
  def new
    @code_lesson_template = CodeLessonTemplate.new
  end

  # GET /code_lesson_templates/1/edit
  def edit
  end

  # POST /code_lesson_templates
  # POST /code_lesson_templates.json
  def create
    @code_lesson_template = CodeLessonTemplate.new(code_lesson_template_params)

    respond_to do |format|
      if @code_lesson_template.save
        format.html { redirect_to @code_lesson_template, notice: 'Code lesson template was successfully created.' }
        format.json { render :show, status: :created, location: @code_lesson_template }
      else
        format.html { render :new }
        format.json { render json: @code_lesson_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /code_lesson_templates/1
  # PATCH/PUT /code_lesson_templates/1.json
  def update
    respond_to do |format|
      if @code_lesson_template.update(code_lesson_template_params)
        format.html { redirect_to @code_lesson_template, notice: 'Code lesson template was successfully updated.' }
        format.json { render :show, status: :ok, location: @code_lesson_template }
      else
        format.html { render :edit }
        format.json { render json: @code_lesson_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /code_lesson_templates/1
  # DELETE /code_lesson_templates/1.json
  def destroy
    @code_lesson_template.destroy
    respond_to do |format|
      format.html { redirect_to code_lesson_templates_url, notice: 'Code lesson template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_code_lesson_template
      @code_lesson_template = CodeLessonTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def code_lesson_template_params
      params.require(:code_lesson_template).permit(:name, :instruction, :hint, :starting_code, :language_id, :order, :track_template_id)
    end
end
