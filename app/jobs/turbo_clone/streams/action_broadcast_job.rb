class TurboClone::Streams::ActionBroadcastJob < ActiveJob::Base
  discard_on ActiveJob::DeserializationError

  def perform(stream, action:, target:, **rendering)
    TurboClone::StreamsChannel.broadcast_action_to(stream, action: action, target: target, **rendering)
  end
end
