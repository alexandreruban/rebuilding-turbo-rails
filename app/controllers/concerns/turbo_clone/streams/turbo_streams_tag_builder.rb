module TurboClone::Streams::TurboStreamsTagBuilder
  private

  def turbo_stream
    TurboClone::Streams::TagBuilder.new(view_context)
  end
end
