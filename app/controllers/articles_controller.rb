class ArticlesController < ApplicationController
	before_action :set_article, only: [:show ,:edit, :update, :destroy]
  before_action :require_permission, only: [:edit, :destroy]
   before_action :require_login, only: [:new, :edit ]
	
	def index
		@articles = Article.all
	end
	def show
    if user_signed_in?
     @comment = Comment.new
     @comment.article_id = @article.id
     @comment.user_id = current_user.id
   end
	end
	def new
		@article = Article.new

	end
	def create
		@article = Article.new(article_params)
		@article.user_id = current_user.id
    respond_to do |format|
      if @article.save
        format.html { redirect_to article_path(@article), notice: 'Article was successfully created.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
	end
	 def update
	 	@article.user_id = current_user.id
          respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_path(@article), notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
   end
     def edit
     end
     def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
private
  def set_article
    @article =Article.find(params[:id])
  
  end
  def article_params
   params.require(:article).permit(:title, :description , :photo , :user_id)
end
def require_permission
  if user_signed_in?
  if @article.user_id != current_user.id
    redirect_to root_path
    flash.notice ='Not your article' 
  end
  end
end
def require_login
   if !user_signed_in? 
    redirect_to root_path
    flash.notice ='You need to SIGN UP / LOG IN.' 
  end
end
 
end