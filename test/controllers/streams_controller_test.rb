require "test_helper"

class TurboClone::StreamsControllerTest < ActionDispatch::IntegrationTest
  test "create with respond to" do
    post articles_path, params: { article: { content: "something" } }
    assert_redirected_to articles_path

    post articles_path, params: { article: { content: "something" } }, as: :turbo_stream
    assert_turbo_stream action: "prepend", target: "articles"
  end

  test "update with respond to" do
    article = Article.create! content: "something"

    patch article_path(article), params: { article: { content: "something else" } }
    assert_redirected_to articles_path

    patch article_path(article), params: { article: { content: "something different" } }, as: :turbo_stream
    assert_turbo_stream action: "replace", target: article
  end

  test "destroy with respond to" do
    article = Article.create! content: "something"

    delete article_path(article)
    assert_redirected_to articles_path

    article = Article.create! content: "something else"

    delete article_path(article), as: :turbo_stream
    assert_turbo_stream action: "remove", target: article
  end
end
