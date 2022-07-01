require "test_helper"

class TurboClone::StreamsHelperTest < ActionView::TestCase
  test "with a string streamable" do
    signed_stream_name = TurboClone::StreamsChannel.signed_stream_name("articles")

    assert_dom_equal \
      %(<turbo-cable-stream-source channel="TurboClone::StreamsChannel" signed-stream-name="#{signed_stream_name}"></turbo-cable-stream-source>),
      turbo_stream_from("articles")
  end

  test "with a model streamable" do
    article = Article.new(id: 1)
    signed_stream_name = TurboClone::StreamsChannel.signed_stream_name(article)

    assert_dom_equal \
      %(<turbo-cable-stream-source channel="TurboClone::StreamsChannel" signed-stream-name="#{signed_stream_name}"></turbo-cable-stream-source>),
      turbo_stream_from(article)
  end

  test "with multiple streamables" do
    article = Article.new(id: 1)
    signed_stream_name = TurboClone::StreamsChannel.signed_stream_name(["articles", article])

    assert_dom_equal \
      %(<turbo-cable-stream-source channel="TurboClone::StreamsChannel" signed-stream-name="#{signed_stream_name}"></turbo-cable-stream-source>),
      turbo_stream_from("articles", article)
  end
end
