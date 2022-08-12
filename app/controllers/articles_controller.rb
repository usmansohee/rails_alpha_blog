class ArticlesController < ApplicationController

  before_action :set_article, only: [:edit, :update, :show, :destroy]

  def index
    @article = Article.all
  end

  def new     #used fo forms only
    @article = Article.new
  end

  def create
    @article = Article.new(articles_params)
    if @article.save
      flash[:info] = "Article Created Successfully"
      puts @article.inspect
      redirect_to article_path(@article)        #send hash as payload to the show action
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit   #used for form
  end

  def update
    if @article.update(articles_params)
      redirect_to article_path(@article)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    flash[:danger] = "Article Deleted"
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def articles_params
    params.require(:article).permit(:title, :description)
  end

end
