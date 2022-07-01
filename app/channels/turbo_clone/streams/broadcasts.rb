module TurboClone::Streams::Broadcasts
  include TurboClone::ActionHelper

  def broadcast_append_to(*streamables, **options)
    broadcast_action_to(*streamables, action: :append, **options)
  end

  def broadcast_prepend_to(*streamables, **options)
    broadcast_action_to(*streamables, action: :prepend, **options)
  end

  def broadcast_replace_to(*streamables, **options)
    broadcast_action_to(*streamables, action: :replace, **options)
  end

  def broadcast_remove_to(*streamables, **options)
    broadcast_action_to(*streamables, action: :remove, **options)
  end

  def broadcast_action_to(*streamables, action:, target: nil, **rendering)
    broadcast_stream_to *streamables, content: turbo_stream_action_tag(
      action, target: target, template: (rendering.any? ? render_format(:html, **rendering) : nil)
    )
  end

  def broadcast_append_later_to(*streamables, **options)
    broadcast_action_later_to(*streamables, action: :append, **options)
  end

  def broadcast_action_later_to(*streamables, action:, target: nil, **rendering)
    TurboClone::Streams::ActionBroadcastJob.perform_later(
      stream_name_from(streamables), action: action, target: target, **rendering
    )
  end

  def broadcast_stream_to(*streamables, content:)
    ActionCable.server.broadcast stream_name_from(streamables), content
  end

  private

  def render_format(format, **rendering)
    ApplicationController.render(formats: [format], **rendering)
  end
end
