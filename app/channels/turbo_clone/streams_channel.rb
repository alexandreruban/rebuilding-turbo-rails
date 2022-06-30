class TurboClone::StreamsChannel < ActionCable::Channel::Base
  def subscribed
    stream_from params[:signed_stream_name]
  end
end
