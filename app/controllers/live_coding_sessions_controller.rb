class LiveCodingSessionsController < ApplicationController
  before_action :authenticate_teacher!, only: [:index]

  def index
    @live_coding_sessions = current_teacher.live_coding_sessions.where(resolved: false)
  end

  def show
    @live_coding_session = LiveCodingSession.find(params[:id])
    @code_lesson = @live_coding_session.code_lesson
    @chat = Chat.find_or_create_by(
      code_lesson_id: @code_lesson.id,
      student_id: @live_coding_session.student_id
    )
    @message = ChatMessage.new
  end

  def create
    params = live_coding_session_params.merge!({
      student_id: current_student.id
    })

    @live_coding_session = LiveCodingSession.new(params)

    respond_to do |format|
      if @live_coding_session.save
        format.html { redirect_to @live_coding_session.code_lesson }
        format.json { render json: @live_coding_session, status: :created }
      else
        format.html { redirect_to request.referrer }
        format.json { render json: @live_coding_session.errors, status: :unprocessable_entity }
      end
    end
  end

  def publish_code
    ActionCable.server.broadcast(
      "live_coding_session_channel_#{params[:live_coding_session_id]}",
      code: params[:code],
      cursor_pos: params[:cursor_pos]
    )

    head :ok
  end

  def resolve
    @live_coding_session = LiveCodingSession.find(params[:id])
    @live_coding_session.resolved = true
    @live_coding_session.save

    redirect_to request.referrer
  end

  private

    def live_coding_session_params
      params.require(:live_coding_session).permit(
        :teacher_id, :code_lesson_id, :starting_code
      )
    end
end
