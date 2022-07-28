class ArticlesController < ApplicationController

  def index
    @article = Article.all
  end

  def new     #used fo forms only
    @article = Article.new
  end

  def create
    @article = Article.new(articles_params)
    if @article.save
      flash[:notice] = "article created successfully"
      puts @article.inspect
      redirect_to article_path(@article)        #send hash as payload to the show action
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @article = Article.find(params[:id])      #from hash-payload used id to find article id.
  end

  def edit    #used for form
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(articles_params)
      redirect_to article_path(@article)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def delete
    @article = Article.find(params[:id])
    @article.destroy
  end

  private

  def articles_params
    params.require(:article).permit(:title, :description)
  end

end
