class TurboClone::Streams::TagBuilder
  def initialize(view_context)
    @view_context = view_context
    @view_context.formats |= [:html]
  end

  def replace(target, content = nil, **rendering, &block)
    action :replace, target, content, **rendering, &block
  end

  def update(target, content = nil, **rendering, &block)
    action :update, target, content, **rendering, &block
  end

  def prepend(target, content = nil, **rendering, &block)
    action :prepend, target, content, **rendering, &block
  end

  def remove(target)
    action :remove, target
  end

  private

  def action(name, target, content = nil, **rendering, &block)
    template = render_template(target, content, **rendering, &block) unless name == :remove

    turbo_stream_action_tag(name, target: target, template: template)
  end

  def turbo_stream_action_tag(action, target:, template:)
    template = action == :remove ? "" : "<template>#{template}</template>"

    if target = convert_to_turbo_stream_dom_id(target)
      %(<turbo-stream target="#{target}" action="#{action}">#{template}</turbo-stream>).html_safe
    else
      raise ArgumentError, "target must be supplied"
    end
  end

  def convert_to_turbo_stream_dom_id(target)
    if target.respond_to?(:to_key)
      ActionView::RecordIdentifier.dom_id(target)
    else
      target
    end
  end

  def render_template(target, content = nil, **rendering, &block)
    if content
      content.respond_to?(:to_partial_path) ? @view_context.render(partial: content, formats: :html) : content
    elsif block_given?
      @view_context.capture(&block)
    elsif rendering.any?
      @view_context.render(**rendering, formats: :html)
    else
      @view_context.render(partial: target, formats: :html)
    end
  end
end
