class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      respond_to do |format|
        format.html { redirect_to articles_path }
        format.turbo_stream
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      respond_to do |format|
        format.html { redirect_to articles_path }
        format.turbo_stream
      end
    else
      render :edit
    end
  end

  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_path }
      format.turbo_stream
    end
  end

  private

  def article_params
    params.require(:article).permit(:content)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
