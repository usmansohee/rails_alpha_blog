class ArticlesController < ApplicationController

  before_action :set_article, only: [:edit, :update, :show, :destroy] #getting data against provided id
  before_action :require_user, except: [:index, :show]  # user must login to perform these actions
  before_action :check_logged_in_user, only: [:edit, :update, :destroy] # restrict logged-in user to perform only its own actions or change-details.

  def index
    @article = Article.all
  end

  def show
  end

  def new     #used fo forms only
    @article = Article.new
  end

  def create
    @article = Article.new(articles_params)
    @article.user = current_user
    if @article.save
      flash[:info] = "Article Created Successfully"
      redirect_to article_path(@article)        #send hash as payload to the show action
    else
      render :new, status: :unprocessable_entity
    end
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

  def check_logged_in_user
    if !logged_in && current_user and !current_user.admin?
      flash[:danger] = "you are allowed to perform action on only your account"
      redirect_to root_path
    end
  end

end
