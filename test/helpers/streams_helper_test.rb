require "test_helper"

class TurboClone::StreamsHelperTest < ActionView::TestCase
  test "with a string streamable" do
    assert_dom_equal \
      %(<turbo-cable-stream-source channel="TurboClone::StreamsChannel" signed-stream-name="articles"></turbo-cable-stream-source>),
      turbo_stream_from("articles")
  end

  test "with a model streamable" do
    article = Article.new(id: 1)

    assert_dom_equal \
      %(<turbo-cable-stream-source channel="TurboClone::StreamsChannel" signed-stream-name="article_1"></turbo-cable-stream-source>),
      turbo_stream_from(article)
  end

  test "with multiple streamables" do
    article = Article.new(id: 1)

    assert_dom_equal \
      %(<turbo-cable-stream-source channel="TurboClone::StreamsChannel" signed-stream-name="articles:article_1"></turbo-cable-stream-source>),
      turbo_stream_from("articles", article)
  end
end
