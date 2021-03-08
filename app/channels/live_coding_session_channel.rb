class LiveCodingSessionChannel < ApplicationCable::Channel
  def subscribed
    live_coding_session_id = params[:live_coding_session_id]
    stream_from "live_coding_session_channel_#{live_coding_session_id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
