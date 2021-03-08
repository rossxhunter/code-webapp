require 'net/http'

class CodeLessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_teacher!, only: [:edit, :update, :new, :create, :destroy]
  before_action :authenticate_teacher_or_student!, only: :show

  # GET /lessons
  # GET /lessons.json
  def index
    @track = Track.find(params[:track_id])
    @code_lessons = @track.code_lessons
    @code_lesson = CodeLesson.new
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    if student_signed_in?
      @submissions = @code_lesson.submissions.where(student_id: current_student.id).order(created_at: :desc)
      @chat = Chat.find_or_create_by(code_lesson_id: @code_lesson.id, student_id: current_student.id)
      @message = ChatMessage.new
      @live_coding_session = LiveCodingSession.find_by(code_lesson_id: @code_lesson.id, student_id: current_student.id, resolved: false)
    end

    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      autolink: true,
      space_after_headers: true,
      fenced_code_blocks: true,
      prettify: true
    )

    @instructions = markdown.render(@code_lesson.instructions).html_safe
    @new_live_coding_session = LiveCodingSession.new
    @lesson_starting_code = @submissions && @submissions.any? ? @submissions.first.code : @code_lesson.starting_code
  end

  # GET /lessons/new
  def new
    @track = Track.find(params[:track_id])
    @code_lesson = CodeLesson.new
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @track = Track.find(params[:track_id])
    @code_lesson = @track.code_lessons.build(code_lesson_params)

    respond_to do |format|
      if @code_lesson.save
        format.html { redirect_to edit_code_lesson_path(@code_lesson), notice: 'Lesson was successfully created.' }
        format.json { render :edit, status: :created, location: @code_lesson }
      else
        format.html { render 'code_lessons/index', locals: { status: 'error' } }
        format.json { render json: @code_lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    respond_to do |format|
      if @code_lesson.update(code_lesson_params)
        format.html { redirect_to @code_lesson, notice: 'Lesson was successfully updated.' }
        format.json { render :show, status: :ok, location: @code_lesson }
      else
        format.html { render :edit }
        format.json { render json: @code_lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @code_lesson.destroy
    respond_to do |format|
      format.html { redirect_to request.referer, notice: 'Lesson was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def run_code
    @code_lesson = CodeLesson.find(params[:id])
    ret_obj = evaluate_code params[:user_code], @code_lesson.language

    success = @code_lesson.check_correctness(params[:user_code], ret_obj['output'])

    points = current_student.points

    if !current_student.has_completed?(@code_lesson) && success
      points = points + 10
      @track = @code_lesson.track
      @next_lesson = CodeLesson.find_by(order: @code_lesson.order + 1, track_id: @track.id)
      if @next_lesson.nil?
        points = points + 30
        @course = @track.course
        @next_track = Track.find_by(order: @track.order + 1, course_id: @course.id)
        if @next_track.nil?
          points = points + 50
        end
      end
      current_student.points = points
      current_student.save
    end

    previous_submissions = Submission.where(student_id: current_student.id, code_lesson_id: @code_lesson.id).order({created_at: :desc})
    time_taken = params[:time_taken].to_i
    if previous_submissions.size > 0
      old_time = previous_submissions.first.time_taken

      # to avoid errors from seed data with no time_taken attribute
      if old_time == nil
        old_time = 0
      end
      time_taken = time_taken + old_time
    end

    Submission.create(
      code_lesson_id: @code_lesson.id,
      code: params[:user_code],
      student_id: current_student.id,
      success: success,
      time_taken: time_taken
    )

    ret_obj.merge!({
      display_hint: @code_lesson.display_hint?(current_student),
      success: success
    })

    render json: ret_obj
  end

  def get_hint
    @code_lesson = CodeLesson.find(params[:id])
    @recent_submission = @code_lesson.most_recent_submission_for(current_student)

    if @code_lesson.display_hint?(current_student)
      @recent_submission.used_hint = true
      @recent_submission.save

      render json: {
        success: true,
        hint: @code_lesson.hint
      }
    else
      render json: {
        success: false,
        hint: nil
      }
    end
  end

  def get_starting_code
    @code_lesson = CodeLesson.find(params[:id])
    return_obj = {
      starting_code: @code_lesson.starting_code
    }
    render json: return_obj.to_json.inspect
  end

  def get_next_lesson
    @code_lesson = CodeLesson.find(params[:id])
    @track = @code_lesson.track
    @next_lesson = CodeLesson.find_by(order: @code_lesson.order + 1, track_id: @track.id)
    if @next_lesson.nil?
      @course = @track.course
      @next_track = Track.find_by(order: @track.order + 1, course_id: @course.id)
      if @next_track.nil?
        @next_lesson = nil
      else
        @next_lesson = CodeLesson.find_by(order: 0, track_id: @next_track.id)
      end
    end
    return_obj = {
      next_lesson: @next_lesson
    }
    render json: return_obj.to_json.inspect
  end

  def chat
    @code_lesson = CodeLesson.find(params[:code_lesson_id])
    @chat = Chat.find(params[:chat_id])
    @message = ChatMessage.new
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @code_lesson = CodeLesson.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def code_lesson_params
      params.fetch(:code_lesson).permit(
        :track_id, :name, :instructions, :language_id, :visible, :hint,
        :display_hint_after_attempts, :display_hint_after_minutes,
        :correctness_test, :starting_code
      )
    end

    def authenticate_teacher_or_student!
      if !teacher_signed_in? && !student_signed_in?
        redirect_to root_path, notice: 'You need to be signed in to view this page'
      end
    end
end
