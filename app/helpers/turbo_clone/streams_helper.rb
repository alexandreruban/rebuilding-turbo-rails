module TurboClone::StreamsHelper
  def turbo_stream
    TurboClone::Streams::TagBuilder.new(self)
  end
end
