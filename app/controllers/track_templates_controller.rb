class TrackTemplatesController < ApplicationController
  before_action :set_track_template, only: [:show, :edit, :update, :destroy]

  # GET /track_templates
  # GET /track_templates.json
  def index
    @track_templates = TrackTemplate.all
  end

  # GET /track_templates/1
  # GET /track_templates/1.json
  def show
  end

  # GET /track_templates/new
  def new
    @track_template = TrackTemplate.new
  end

  # GET /track_templates/1/edit
  def edit
  end

  # POST /track_templates
  # POST /track_templates.json
  def create
    @track_template = TrackTemplate.new(track_template_params)

    respond_to do |format|
      if @track_template.save
        format.html { redirect_to @track_template, notice: 'Track template was successfully created.' }
        format.json { render :show, status: :created, location: @track_template }
      else
        format.html { render :new }
        format.json { render json: @track_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /track_templates/1
  # PATCH/PUT /track_templates/1.json
  def update
    respond_to do |format|
      if @track_template.update(track_template_params)
        format.html { redirect_to @track_template, notice: 'Track template was successfully updated.' }
        format.json { render :show, status: :ok, location: @track_template }
      else
        format.html { render :edit }
        format.json { render json: @track_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /track_templates/1
  # DELETE /track_templates/1.json
  def destroy
    @track_template.destroy
    respond_to do |format|
      format.html { redirect_to track_templates_url, notice: 'Track template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_track_template
      @track_template = TrackTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def track_template_params
      params.require(:track_template).permit(:name, :order, :course_id, :description)
    end
end
