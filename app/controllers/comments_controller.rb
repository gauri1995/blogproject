class CommentsController < ApplicationController
	before_action :set_comment, only: [:show, :edit, :update, :destroy]
    before_action :set_article
     before_action :comment_permission, only: [:edit, :update, :destroy]
     before_action :require_login, only: [:index, :show, :new, :edit ]
    
	def show

	end
	def create
      @comment = Comment.new(comment_params)
      @comment.article_id = params[:article_id]
      @comment.user_id = current_user.id
       @comment.save
      redirect_to article_path(@article)
       flash.notice ='Comment was successfully created.' 
   end
   def edit
   end
   def update
   	respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to article_path(@article), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
   end
   def destroy
   	@comment.destroy
    respond_to do |format|
      format.html { redirect_to article_path(@article), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
   end
   def set_comment
      @comment = Comment.find(params[:id])
    end
    def set_article
      @article = Article.find(params[:article_id])
    end
    def comment_params
      params.require(:comment).permit(:author, :body)
    end
     def comment_permission
      if user_signed_in?
        if @comment.user_id != current_user.id
          redirect_to article_path(@article)
          flash.notice ='Not your comment' 
        end
      end
    end
 def require_login
   if !user_signed_in? 
    redirect_to root_path
    flash.notice ='Not authorized to do this task' 
    
  end
 end
end
