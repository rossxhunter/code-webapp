class OrganisationClassesController < ApplicationController
  before_action :set_organisation_class, only: [:show, :edit, :update, :destroy, :courses]
  before_action :authenticate_teacher!, only: [:new, :create, :edit, :update, :destroy]

  # GET /organisation_classes
  # GET /organisation_classes.json
  def index
    @organisation_classes = OrganisationClass.all
  end

  # GET /organisation_classes/1
  # GET /organisation_classes/1.json
  def show
  end

  # GET /organisation_classes/new
  def new
    @organisation_class = OrganisationClass.new
  end

  # GET /organisation_classes/1/edit
  def edit
  end

  # POST /organisation_classes
  # POST /organisation_classes.json
  def create
    @organisation_class = current_teacher.organisation_classes.build(organisation_class_params)

    respond_to do |format|
      if @organisation_class.save
        current_teacher.teachers_classes.create({
          teacher_id: current_teacher.id,
          organisation_class_id: @organisation_class.id
        })
        format.html { redirect_to @organisation_class, notice: 'Organisation class was successfully created.' }
        format.json { render :show, status: :created, location: @organisation_class }
      else
        format.html { render :new }
        format.json { render json: @organisation_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organisation_classes/1
  # PATCH/PUT /organisation_classes/1.json
  def update
    respond_to do |format|
      if @organisation_class.update(organisation_class_params)
        format.html { redirect_to @organisation_class, notice: 'Organisation class was successfully updated.' }
        format.json { render :show, status: :ok, location: @organisation_class }
      else
        format.html { render :edit }
        format.json { render json: @organisation_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organisation_classes/1
  # DELETE /organisation_classes/1.json
  def destroy
    @organisation_class.destroy
    respond_to do |format|
      format.html { redirect_to organisation_classes_url, notice: 'Organisation class was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def courses
    @courses = @organisation_class.courses
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organisation_class
      @organisation_class = OrganisationClass.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organisation_class_params
      params.require(:organisation_class).permit(:name, :code, :organisation_id)
    end
end
