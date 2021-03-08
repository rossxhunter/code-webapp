class ChatMessagesController < ApplicationController

  def create
    message = ChatMessage.new(message_params)

    if student_signed_in?
      message.messageable_type = 'Student'
      message.messageable_id = current_student.id
    end

    if teacher_signed_in?
      message.messageable_type = 'Teacher'
      message.messageable_id = current_teacher.id
    end

    if message.save
      ActionCable.server.broadcast(
        'messages',
        message: message.message,
        user_name: message.messageable.name,
        image: ActionController::Base.helpers.image_tag('icon-person-128.png', class: 'chat-message-icon'),
        type: message.messageable_type
      )

      head :ok
    else
      redirect_to request.referrer
    end
  end

  private

    def message_params
      params.require(:chat_message).permit(:message, :chat_id)
    end
end
