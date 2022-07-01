class TurboClone::StreamsChannel < ActionCable::Channel::Base
  extend TurboClone::Streams::StreamName, TurboClone::Streams::Broadcasts

  def subscribed
    if verified_stream_name = self.class.verified_stream_name(params[:signed_stream_name])
      stream_from verified_stream_name
    else
      reject
    end
  end
end
